import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_profile_entity.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    @JsonKey(name: 'auth_user_id') required String authUserId,
    @JsonKey(name: 'public_profile_id') required String publicProfileId,
    required String nickname,
    String? bio,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'age_group_code') String? ageGroupCode,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  factory UserProfileModel.fromEntity(UserProfileEntity entity) {
    return UserProfileModel(
      authUserId: entity.authUserId,
      publicProfileId: entity.publicProfileId,
      nickname: entity.nickname,
      bio: entity.bio,
      profileImageUrl: entity.profileImageUrl,
      genderCode: entity.genderCode,
      ageGroupCode: entity.ageGroupCode,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  const UserProfileModel._();

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      authUserId: authUserId,
      publicProfileId: publicProfileId,
      nickname: nickname,
      bio: bio,
      profileImageUrl: profileImageUrl,
      genderCode: genderCode,
      ageGroupCode: ageGroupCode,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
