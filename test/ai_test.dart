import 'package:aqualog/core/database/database_provider.dart';
import 'package:aqualog/features/ai/data/ai_service.dart';
import 'package:aqualog/features/ai/data/tank_context_builder.dart';
import 'package:aqualog/features/ai/domain/chat_message.dart';
import 'package:aqualog/features/ai/domain/tank_analysis.dart';
import 'package:aqualog/features/ai/presentation/controllers/ai_providers.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Replies from a script instead of calling Cloud Functions
class _FakeAiService extends AiService {
  _FakeAiService(this.replies) : super(TankContextBuilder(_unusedDb));

  static final _unusedDb = AppDatabase(NativeDatabase.memory());

  final List<Object> replies;
  final List<List<ChatMessage>> sentHistories = [];

  @override
  bool get isAvailable => true;

  @override
  Future<String> chat({
    required List<ChatMessage> history,
    int? tankId,
  }) async {
    sentHistories.add(history);
    final next = replies.removeAt(0);
    if (next is AiException) throw next;
    return next as String;
  }
}

void main() {
  group('TankAnalysis.fromJson', () {
    test('parses a model response and orders actions by priority', () {
      final analysis = TankAnalysis.fromJson({
        'status': 'attention',
        'score': 104.6,
        'headline': 'Nitrate is creeping up',
        'summary': 'Mostly stable.',
        'findings': [
          {'title': 'pH stable', 'severity': 'good', 'detail': '7.0'},
        ],
        'actions': [
          {'title': 'Trim plants', 'detail': '', 'priority': 'routine'},
          {'title': 'Change 30% water', 'detail': '', 'priority': 'now'},
        ],
      });

      expect(analysis.status, TankHealthStatus.attention);
      expect(analysis.score, 100);
      expect(analysis.findings.single.severity, FindingSeverity.good);
      expect(analysis.actions.first.title, 'Change 30% water');
    });

    test('falls back safely on unexpected values', () {
      final analysis = TankAnalysis.fromJson({
        'status': 'great',
        'findings': [
          'not a map',
          {'severity': 'unknown'},
        ],
      });

      expect(analysis.status, TankHealthStatus.attention);
      expect(analysis.score, 0);
      expect(analysis.findings.single.severity, FindingSeverity.info);
      expect(analysis.actions, isEmpty);
    });

    test('round-trips through toJson for the on-device cache', () {
      final original = TankAnalysis.fromJson({
        'status': 'healthy',
        'score': 88,
        'headline': 'All good',
        'summary': 'Stable.',
        'findings': const [],
        'actions': [
          {'title': 'Test water', 'detail': 'Weekly', 'priority': 'soon'},
        ],
      }, createdAt: DateTime(2026, 11, 1, 9));

      final copy = TankAnalysis.fromJson(original.toJson());
      expect(copy.score, 88);
      expect(copy.createdAt, DateTime(2026, 11, 1, 9));
      expect(copy.actions.single.priority, ActionPriority.soon);
    });
  });

  group('TankContextBuilder', () {
    late AppDatabase db;

    setUp(() => db = AppDatabase(NativeDatabase.memory()));
    tearDown(() => db.close());

    test('describes the tank without ids, paths or empty sections', () async {
      final tankId = await db.insertTank(
        TanksCompanion.insert(
          name: 'Betta tank',
          tankType: TankType.planted,
          volumeLiters: 22.5,
        ),
      );
      await db.insertFish(
        FishCompanion.insert(
          tankId: tankId,
          species: 'Betta splendens',
          quantity: const Value(1),
        ),
      );
      await db.insertWaterParameters(
        WaterParametersCompanion.insert(
          tankId: tankId,
          measuredAt: DateTime(2026, 10, 29),
          ph: const Value(7.04),
          nitratePpm: const Value(20),
        ),
      );

      final context = await TankContextBuilder(
        db,
      ).build(tankId, now: DateTime(2026, 11, 1));

      expect(context, isNotNull);
      expect(context!['tank'], containsPair('name', 'Betta tank'));
      expect(context['tank'], isNot(contains('id')));
      expect((context['fish'] as List).single, isNot(contains('tankId')));
      final test = (context['waterTests'] as List).single as Map;
      expect(test['pH'], 7.04);
      expect(test['daysAgo'], 3);
      expect(test, isNot(contains('ammoniaPpm')));
      expect(context, isNot(contains('plants')));
    });

    test('returns null for a missing tank', () async {
      expect(await TankContextBuilder(db).build(999), isNull);
    });
  });

  group('ChatController', () {
    test('adds replies, shows errors in the thread and retries', () async {
      final fake = _FakeAiService([
        'Hello! Your tank looks stable.',
        const AiException('The assistant is unavailable right now.'),
        'Do a 25% water change.',
      ]);
      final container = ProviderContainer(
        overrides: [aiServiceProvider.overrideWithValue(fake)],
      );
      addTearDown(container.dispose);
      final controller = container.read(chatControllerProvider(1).notifier);

      await controller.send('Hi');
      await controller.send('What now?');
      var state = container.read(chatControllerProvider(1));
      expect(state.messages.map((m) => m.text), [
        'Hi',
        'Hello! Your tank looks stable.',
        'What now?',
        'The assistant is unavailable right now.',
      ]);
      expect(state.messages.last.isError, isTrue);

      await controller.retry();
      state = container.read(chatControllerProvider(1));
      expect(state.messages.last.text, 'Do a 25% water change.');
      expect(state.messages.where((m) => m.isError), isEmpty);
      // The retried request carried the full history, without the error
      expect(fake.sentHistories.last.map((m) => m.text), [
        'Hi',
        'Hello! Your tank looks stable.',
        'What now?',
      ]);
    });

    test('keeps a separate conversation per tank', () async {
      final container = ProviderContainer(
        overrides: [
          aiServiceProvider.overrideWithValue(_FakeAiService(['Reply'])),
        ],
      );
      addTearDown(container.dispose);

      await container.read(chatControllerProvider(1).notifier).send('Hi');
      expect(container.read(chatControllerProvider(1)).messages, hasLength(2));
      expect(container.read(chatControllerProvider(2)).messages, isEmpty);
    });
  });
}
