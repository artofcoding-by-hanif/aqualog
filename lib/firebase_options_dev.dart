// Placeholder until Firebase is configured for the dev flavor.
//
// Generate the real file with:
//   flutterfire configure --project=<firebase-project-id> \
//     --out=lib/firebase_options_dev.dart --platforms=android,ios
//
// Until then AI features report "not set up" and the rest of the app works
// offline as before.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    throw UnsupportedError(
      'Firebase is not configured for the dev flavor yet. '
      'Run flutterfire configure (see lib/firebase_options_dev.dart).',
    );
  }
}
