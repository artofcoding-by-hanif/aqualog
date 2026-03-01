import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dev configuration
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
