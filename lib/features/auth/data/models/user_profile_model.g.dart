// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileModelImpl(
  authUserId: json['auth_user_id'] as String,
  publicProfileId: json['public_profile_id'] as String,
  nickname: json['nickname'] as String,
  bio: json['bio'] as String?,
  profileImageUrl: json['profile_image_url'] as String?,
  genderCode: json['gender_code'] as String?,
  ageGroupCode: json['age_group_code'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$UserProfileModelImplToJson(
  _$UserProfileModelImpl instance,
) => <String, dynamic>{
  'auth_user_id': instance.authUserId,
  'public_profile_id': instance.publicProfileId,
  'nickname': instance.nickname,
  'bio': instance.bio,
  'profile_image_url': instance.profileImageUrl,
  'gender_code': instance.genderCode,
  'age_group_code': instance.ageGroupCode,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
