import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure Storage 래퍼
/// 
/// 토큰, 리프레시 토큰, 민감한 정보를 안전하게 저장한다.
class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage() : _storage = const FlutterSecureStorage();

  /// 값 저장
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// 값 읽기
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// 값 삭제
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// 모든 값 삭제
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
