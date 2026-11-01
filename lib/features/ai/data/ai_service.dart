import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/firebase/firebase_bootstrap.dart';
import '../domain/chat_message.dart';
import '../domain/tank_analysis.dart';
import 'tank_context_builder.dart';

/// User-facing AI failure; [message] is safe to show as-is
class AiException implements Exception {
  const AiException(this.message, {this.isQuota = false});

  final String message;

  /// The daily limit was reached (the paywall hooks in here later)
  final bool isQuota;

  @override
  String toString() => message;
}

/// Talks to the `aiChat` and `analyzeTank` Cloud Functions.
///
/// The Gemini key lives only on the server; the app signs in anonymously and
/// sends the tank's context with each request.
class AiService {
  AiService(this._contextBuilder);

  final TankContextBuilder _contextBuilder;

  static const _timeout = Duration(seconds: 70);

  bool get isAvailable => FirebaseBootstrap.isReady;

  Future<String> chat({required List<ChatMessage> history, int? tankId}) async {
    final data = await _call('aiChat', {
      'tankContext': tankId == null
          ? null
          : await _contextBuilder.build(tankId),
      'messages': history
          .where((m) => !m.isError)
          .map((m) => {'role': m.role.name, 'text': m.text})
          .toList(),
    });
    final reply = data['reply'];
    if (reply is! String || reply.isEmpty) {
      throw const AiException('The assistant sent an empty reply.');
    }
    return reply;
  }

  Future<TankAnalysis> analyze(int tankId) async {
    final context = await _contextBuilder.build(tankId);
    if (context == null) throw const AiException('Tank not found.');

    final data = await _call('analyzeTank', {'tankContext': context});
    final analysis = data['analysis'];
    if (analysis is! Map) {
      throw const AiException('The assistant sent an unreadable report.');
    }
    return TankAnalysis.fromJson(
      Map<String, dynamic>.from(analysis),
      createdAt: DateTime.now(),
    );
  }

  Future<Map<String, dynamic>> _call(
    String name,
    Map<String, dynamic> payload,
  ) async {
    if (!isAvailable) {
      throw const AiException('AI features are not set up in this build yet.');
    }

    try {
      await _ensureSignedIn();
      final result = await FirebaseFunctions.instance
          .httpsCallable(name, options: HttpsCallableOptions(timeout: _timeout))
          .call(payload);
      // Platform channels deliver Map<Object?, Object?>
      return Map<String, dynamic>.from(result.data as Map);
    } on FirebaseFunctionsException catch (e) {
      throw _mapFunctionsError(e);
    } on FirebaseAuthException {
      throw const AiException(
        'Could not connect to the assistant. Check your internet connection.',
      );
    }
  }

  Future<void> _ensureSignedIn() async {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      await auth.signInAnonymously();
    }
  }

  AiException _mapFunctionsError(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'resource-exhausted':
        return AiException(
          e.message ?? 'Daily AI limit reached.',
          isQuota: true,
        );
      case 'invalid-argument':
        return AiException(e.message ?? 'The request was not valid.');
      case 'unauthenticated':
      case 'permission-denied':
        return const AiException(
          'This app build is not verified for AI features yet.',
        );
      case 'deadline-exceeded':
        return const AiException(
          'The assistant took too long to answer. Please try again.',
        );
      case 'unavailable':
      case 'internal':
      default:
        return AiException(
          e.message ??
              'The assistant is unavailable right now. Please try again.',
        );
    }
  }
}
