import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'core/firebase/firebase_bootstrap.dart';
import 'features/subscription/data/subscription_service.dart';
import 'firebase_options_prod.dart' as firebase_options;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize prod configuration
  AppConfig.initialize(
    flavor: Flavor.prod,
    appName: EnvConfig.prodConfig.appName,
    apiBaseUrl: EnvConfig.prodConfig.apiBaseUrl,
    enableLogging: EnvConfig.prodConfig.enableLogging,
    enableCrashlytics: EnvConfig.prodConfig.enableCrashlytics,
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
