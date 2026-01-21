/// 네트워크 및 API 예외 타입 정의
/// 
/// Data 레이어에서 발생하는 예외를 도메인 레이어로 전달하기 전에
/// 의미 있는 예외 타입으로 변환한다.

/// 네트워크 예외
class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException(this.message, {this.statusCode});

  @override
  String toString() => 'NetworkException: $message';
}

/// 서버 예외
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException(this.message, {this.statusCode});

  @override
  String toString() => 'ServerException: $message';
}

/// 인증 예외
class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// 검증 예외
class ValidationException implements Exception {
  final String message;
  final Map<String, String>? errors;

  const ValidationException(this.message, {this.errors});

  @override
  String toString() => 'ValidationException: $message';
}

/// 알 수 없는 예외
class UnknownException implements Exception {
  final String message;
  final Object? originalError;

  const UnknownException(this.message, {this.originalError});

  @override
  String toString() => 'UnknownException: $message';
}
