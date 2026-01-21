import 'dart:io';
import '../../../auth/domain/entities/user_profile_entity.dart';
import '../entities/bookmarked_place_entity.dart';

/// 프로필 관련 저장소 인터페이스
abstract class ProfileRepository {
  /// 프로필 조회
  Future<UserProfileEntity?> getProfile(String authUserId);

  /// 프로필 업데이트/생성
  Future<UserProfileEntity> upsertProfile({
    required String nickname,
    String? bio,
    String? profileImageUrl,
  });

  /// 프로필 이미지 업로드
  Future<String> uploadProfileImage(File file, String userId);

  /// 저장(북마크)한 장소 목록 조회
  Future<List<BookmarkedPlaceEntity>> getMyBookmarkedPlaces({
    int limit,
    int offset,
  });
}
