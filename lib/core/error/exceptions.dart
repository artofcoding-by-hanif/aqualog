/// Custom exceptions

class ServerException implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  String toString() => message ?? 'Server Exception';
}

class CacheException implements Exception {
  final String? message;

  const CacheException([this.message]);

  @override
  String toString() => message ?? 'Cache Exception';
}

class NetworkException implements Exception {
  final String? message;

  const NetworkException([this.message]);

  @override
  String toString() => message ?? 'Network Exception';
}

class ValidationException implements Exception {
  final String? message;

  const ValidationException([this.message]);

  @override
  String toString() => message ?? 'Validation Exception';
}
