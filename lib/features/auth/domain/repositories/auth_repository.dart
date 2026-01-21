import '../entities/user_entity.dart';
import '../entities/user_profile_entity.dart';

/// 인증 관련 저장소 인터페이스
abstract class AuthRepository {
  /// Google 로그인
  Future<UserEntity?> signInWithGoogle();

  /// 로그아웃
  Future<void> signOut();

  /// 현재 인증된 사용자 조회
  Future<UserEntity?> getCurrentUser();

  /// 사용자 상세 프로필 조회
  Future<UserProfileEntity?> getProfile(String authUserId);

  /// 인증 상태 스트림
  Stream<UserEntity?> get authStateChanges;
}
