import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';

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

  // Run app with Riverpod
  runApp(const ProviderScope(child: App()));
}
