import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Starts Firebase if this build has been configured for it.
///
/// Firebase only powers online extras (the AI assistant), so a missing or
/// broken configuration is logged and the app carries on offline.
class FirebaseBootstrap {
  FirebaseBootstrap._();

  static bool _ready = false;

  /// Whether Firebase initialized and online features can be used
  static bool get isReady => _ready;

  /// Optional fixed App Check debug token for debug builds, registered in the
  /// Firebase console. Pass with --dart-define=APP_CHECK_DEBUG_TOKEN=...
  /// Without it, the SDK logs a generated token on first launch.
  static const String _debugToken = String.fromEnvironment(
    'APP_CHECK_DEBUG_TOKEN',
  );

  static Future<void> initialize(FirebaseOptions Function() options) async {
    try {
      await Firebase.initializeApp(options: options());
      await FirebaseAppCheck.instance.activate(
        providerAndroid: kDebugMode
            ? AndroidDebugProvider(
                debugToken: _debugToken.isEmpty ? null : _debugToken,
              )
            : const AndroidPlayIntegrityProvider(),
        providerApple: kDebugMode
            ? AppleDebugProvider(
                debugToken: _debugToken.isEmpty ? null : _debugToken,
              )
            : const AppleAppAttestProvider(),
      );
      _ready = true;
    } catch (error) {
      debugPrint('Firebase unavailable, online features disabled: $error');
    }
  }
}
