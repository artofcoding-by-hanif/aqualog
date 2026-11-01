import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_provider.dart';
import '../../../../core/settings/settings_provider.dart';
import '../../../../core/storage/local_storage.dart';
import '../../data/ai_service.dart';
import '../../data/tank_context_builder.dart';
import '../../domain/chat_message.dart';
import '../../domain/tank_analysis.dart';

final aiServiceProvider = Provider<AiService>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AiService(TankContextBuilder(db));
});

// ============================================================
// Chat
// ============================================================

class ChatState {
  const ChatState({this.messages = const [], this.isSending = false});

  final List<ChatMessage> messages;
  final bool isSending;

  ChatState copyWith({List<ChatMessage>? messages, bool? isSending}) =>
      ChatState(
        messages: messages ?? this.messages,
        isSending: isSending ?? this.isSending,
      );
}

/// One conversation per tank (null = general questions), kept for the
/// lifetime of the app session
class ChatController extends Notifier<ChatState> {
  ChatController(this.tankId);

  final int? tankId;

  @override
  ChatState build() => const ChatState();

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isSending) return;

    // Drop a previous error bubble so the thread stays clean
    final history = [
      ...state.messages.where((m) => !m.isError),
      ChatMessage.user(trimmed),
    ];
    state = state.copyWith(messages: history, isSending: true);

    try {
      final reply = await ref
          .read(aiServiceProvider)
          .chat(history: history, tankId: tankId);
      state = state.copyWith(
        messages: [...history, ChatMessage.model(reply)],
        isSending: false,
      );
    } on AiException catch (e) {
      state = state.copyWith(
        messages: [...history, ChatMessage.error(e.message)],
        isSending: false,
      );
    }
  }

  /// Resend the last user message after a failure
  Future<void> retry() async {
    final lastUser = state.messages.lastWhere(
      (m) => m.isUser,
      orElse: () => const ChatMessage.user(''),
    );
    if (lastUser.text.isEmpty) return;
    final index = state.messages.lastIndexOf(lastUser);
    state = state.copyWith(messages: state.messages.sublist(0, index));
    await send(lastUser.text);
  }

  void clear() => state = const ChatState();
}

final chatControllerProvider =
    NotifierProvider.family<ChatController, ChatState, int?>(
      ChatController.new,
    );

// ============================================================
// Tank health analysis
// ============================================================

/// Cached health check plus the state of a refresh in progress
class TankAnalysisState {
  const TankAnalysisState({
    this.analysis,
    this.isRefreshing = false,
    this.error,
  });

  /// Latest result, possibly from a previous session
  final TankAnalysis? analysis;
  final bool isRefreshing;

  /// Why the most recent refresh failed, if it did
  final AiException? error;
}

/// Latest AI health check for a tank. The last result is cached on device so
/// it shows instantly and survives restarts; [refresh] asks for a new one.
class TankAnalysisController extends AsyncNotifier<TankAnalysisState> {
  TankAnalysisController(this.tankId);

  final int tankId;

  String get _key => 'ai_analysis_$tankId';

  LocalStorage get _storage => ref.read(localStorageProvider);

  @override
  Future<TankAnalysisState> build() async {
    await _storage.initialize();
    final cached = _storage.getString(_key);
    if (cached == null) return const TankAnalysisState();
    try {
      return TankAnalysisState(
        analysis: TankAnalysis.fromJson(
          jsonDecode(cached) as Map<String, dynamic>,
        ),
      );
    } catch (_) {
      return const TankAnalysisState();
    }
  }

  Future<void> refresh() async {
    final previous = state.value?.analysis;
    if (state.value?.isRefreshing ?? false) return;
    state = AsyncData(
      TankAnalysisState(analysis: previous, isRefreshing: true),
    );
    try {
      final analysis = await ref.read(aiServiceProvider).analyze(tankId);
      await _storage.setString(_key, jsonEncode(analysis.toJson()));
      state = AsyncData(TankAnalysisState(analysis: analysis));
    } on AiException catch (e) {
      state = AsyncData(TankAnalysisState(analysis: previous, error: e));
    }
  }
}

final tankAnalysisProvider =
    AsyncNotifierProvider.family<
      TankAnalysisController,
      TankAnalysisState,
      int
    >(TankAnalysisController.new);
