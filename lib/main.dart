import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';

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

  // Run app with Riverpod
  runApp(const ProviderScope(child: App()));
}
