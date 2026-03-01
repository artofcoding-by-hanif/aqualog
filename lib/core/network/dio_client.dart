/// Dio HTTP client configuration

class DioClient {
  static DioClient? _instance;

  DioClient._();

  static DioClient get instance {
    _instance ??= DioClient._();
    return _instance!;
  }

  // TODO: Add Dio instance and configuration
}

