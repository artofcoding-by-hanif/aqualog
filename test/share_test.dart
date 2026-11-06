import 'package:aqualog/core/theme/app_theme.dart';
import 'package:aqualog/features/ai/domain/tank_analysis.dart';
import 'package:aqualog/features/share/domain/milestones.dart';
import 'package:aqualog/features/share/domain/share_content.dart';
import 'package:aqualog/features/share/presentation/share_cards.dart';
import 'package:aqualog/features/tank/domain/entities/tank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('milestones', () {
    test('reports only the highest milestone reached per type', () {
      final found = milestonesForTank(
        tankId: 1,
        tankName: 'Betta tank',
        daysRunning: 492,
        waterChanges: 27,
        waterTests: 3,
      );
      expect(found.map((m) => m.key), ['1:daysRunning:365', '1:waterChanges:25']);
      expect(found.first.headline, 'Betta tank turned 1 year old!');
      expect(found.first.value, '1');
    });

    test('new tanks have nothing to celebrate yet', () {
      expect(
        milestonesForTank(
          tankId: 2,
          tankName: 'Fresh',
          daysRunning: 12,
          waterChanges: 2,
          waterTests: 0,
        ),
        isEmpty,
      );
      expect(
        milestonesForTank(
          tankId: 3,
          tankName: 'No date',
          daysRunning: null,
          waterChanges: 0,
          waterTests: 0,
        ),
        isEmpty,
      );
    });

    test('30 days is celebrated as fully cycled', () {
      final m = milestonesForTank(
        tankId: 4,
        tankName: 'Shrimp',
        daysRunning: 41,
        waterChanges: 0,
        waterTests: 0,
      ).single;
      expect(m.headline, 'Shrimp is fully cycled!');
      expect(m.unit, 'days · fully cycled');
    });

    test('next milestone skips seen ones and prefers age', () {
      final all = [
        ...milestonesForTank(
          tankId: 1,
          tankName: 'A',
          daysRunning: 120,
          waterChanges: 12,
          waterTests: 0,
        ),
        ...milestonesForTank(
          tankId: 2,
          tankName: 'B',
          daysRunning: 400,
          waterChanges: 0,
          waterTests: 0,
        ),
      ];
      expect(nextMilestone(all, {})!.key, '2:daysRunning:365');
      expect(nextMilestone(all, {'2:daysRunning:365'})!.key, '1:daysRunning:100');
      expect(
        nextMilestone(all, {
          '2:daysRunning:365',
          '1:daysRunning:100',
          '1:waterChanges:10',
        }),
        isNull,
      );
    });
  });

  group('share content', () {
    test('Play link carries a per-card referrer', () {
      final link = ShareLinks.playStore(ShareKind.health);
      expect(link, startsWith('https://play.google.com/store/apps/details?id=com.growdiom.aqualog&referrer='));
      expect(
        Uri.decodeComponent(Uri.parse(link).queryParameters['referrer']!),
        'utm_source=tankmind_share&utm_medium=social&utm_campaign=health',
      );
    });

    test('markdown is flattened for quote cards', () {
      expect(
        plainTextFromMarkdown('**Test your water** today.\n\n\n- Do a *30%* change\n* Clean `filter`'),
        'Test your water today.\n\n• Do a 30% change\n• Clean filter',
      );
    });

    test('excerpts end on a word with an ellipsis', () {
      expect(excerpt('short', 10), 'short');
      expect(excerpt('The quick brown fox jumps', 18), 'The quick brown…');
    });
  });

  group('share cards', () {
    Future<void> pumpCard(WidgetTester tester, Widget card) async {
      tester.view.physicalSize = const Size(1080, 1350);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Scaffold(body: Center(child: card)),
        ),
      );
      await tester.pump();
    }

    final tank = TankEntity(
      id: 1,
      name: 'Betta tank',
      tankType: TankType.planted,
      volumeLiters: 22.5,
      setupDate: DateTime.now().subtract(const Duration(days: 492)),
    );

    testWidgets('tank showcase', (tester) async {
      await pumpCard(
        tester,
        TankShowcaseCard(
          data: TankShowcase(tank: tank, fish: 1, plants: 4, invertebrates: 2),
        ),
      );
      expect(find.text('Betta tank'), findsOneWidget);
      expect(find.textContaining('22.5 L'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('health score', (tester) async {
      await pumpCard(
        tester,
        HealthScoreCard(
          tankName: 'Betta tank',
          analysis: TankAnalysis.fromJson({
            'status': 'healthy',
            'score': 92,
            'headline': 'Stable water and happy fish',
            'summary': '',
            'findings': const [],
            'actions': const [],
          }),
        ),
      );
      expect(find.text('92'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('AI tip with a long answer does not overflow', (tester) async {
      await pumpCard(
        tester,
        AiTipCard(
          question: 'What should I do this week?',
          answer: List.filled(40, '**Test** your water and change 30%.').join(' '),
          tankName: 'Betta tank',
        ),
      );
      expect(find.text('Tip from TankMind AI'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('milestone', (tester) async {
      await pumpCard(
        tester,
        const MilestoneCard(
          milestone: Milestone(
            tankId: 1,
            tankName: 'Betta tank',
            type: MilestoneType.daysRunning,
            threshold: 100,
          ),
        ),
      );
      expect(find.text('100'), findsOneWidget);
      expect(find.text('Betta tank is 100 days old!'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
