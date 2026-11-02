/// Environment-specific configuration values

class EnvConfig {
  EnvConfig._();

  // Development environment
  static const devConfig = _DevConfig();

  // Production environment
  static const prodConfig = _ProdConfig();
}

class _DevConfig {
  const _DevConfig();

  String get appName => 'Aqualog Dev';
  String get appSuffix => '.dev';
  String get apiBaseUrl => 'https://api-dev.aqualog.app';
  bool get enableLogging => true;
  bool get enableCrashlytics => false;
}

class _ProdConfig {
  const _ProdConfig();

  String get appName => 'Aqualog';
  String get appSuffix => '';
  String get apiBaseUrl => 'https://api.aqualog.app';
  bool get enableLogging => false;
  bool get enableCrashlytics => true;
}
