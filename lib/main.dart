import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'core/firebase/firebase_bootstrap.dart';
import 'features/subscription/data/subscription_service.dart';
import 'firebase_options_dev.dart' as firebase_options;

/// Default entry point - uses dev configuration
/// For specific flavors, use main_dev.dart or main_prod.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Default to dev configuration
  AppConfig.initialize(
    flavor: Flavor.dev,
    appName: EnvConfig.devConfig.appName,
    apiBaseUrl: EnvConfig.devConfig.apiBaseUrl,
    enableLogging: EnvConfig.devConfig.enableLogging,
    enableCrashlytics: EnvConfig.devConfig.enableCrashlytics,
  );

  // Online extras (AI); the app works without them
  await FirebaseBootstrap.initialize(
    () => firebase_options.DefaultFirebaseOptions.currentPlatform,
  );
  // Store subscriptions (no-op when RevenueCat keys aren't set)
  await SubscriptionService.instance.initialize();

  // Run app with Riverpod
  runApp(const ProviderScope(child: App()));
}
