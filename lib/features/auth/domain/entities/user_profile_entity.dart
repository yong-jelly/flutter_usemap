import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_entity.freezed.dart';

/// 상세 사용자 프로필 엔티티 (tbl_user_profile)
@freezed
class UserProfileEntity with _$UserProfileEntity {
  const factory UserProfileEntity({
    required String authUserId,
    required String publicProfileId,
    required String nickname,
    String? bio,
    String? profileImageUrl,
    String? genderCode,
    String? ageGroupCode,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfileEntity;
}
