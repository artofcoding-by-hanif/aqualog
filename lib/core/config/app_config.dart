/// Application configuration for different environments

enum Flavor { dev, prod }

class AppConfig {
  AppConfig._();

  static late Flavor _flavor;
  static late String _appName;
  static late String _apiBaseUrl;
  static late bool _enableLogging;
  static late bool _enableCrashlytics;

  static Flavor get flavor => _flavor;
  static String get appName => _appName;
  static String get apiBaseUrl => _apiBaseUrl;
  static bool get enableLogging => _enableLogging;
  static bool get enableCrashlytics => _enableCrashlytics;

  static bool get isDev => _flavor == Flavor.dev;
  static bool get isProd => _flavor == Flavor.prod;

  static void initialize({
    required Flavor flavor,
    required String appName,
    required String apiBaseUrl,
    required bool enableLogging,
    required bool enableCrashlytics,
  }) {
    _flavor = flavor;
    _appName = appName;
    _apiBaseUrl = apiBaseUrl;
    _enableLogging = enableLogging;
    _enableCrashlytics = enableCrashlytics;
  }
}

