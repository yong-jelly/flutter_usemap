// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  @JsonKey(name: 'auth_user_id')
  String get authUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'public_profile_id')
  String get publicProfileId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender_code')
  String? get genderCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_group_code')
  String? get ageGroupCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
    UserProfileModel value,
    $Res Function(UserProfileModel) then,
  ) = _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'auth_user_id') String authUserId,
    @JsonKey(name: 'public_profile_id') String publicProfileId,
    String nickname,
    String? bio,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'age_group_code') String? ageGroupCode,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authUserId = null,
    Object? publicProfileId = null,
    Object? nickname = null,
    Object? bio = freezed,
    Object? profileImageUrl = freezed,
    Object? genderCode = freezed,
    Object? ageGroupCode = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            authUserId: null == authUserId
                ? _value.authUserId
                : authUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            publicProfileId: null == publicProfileId
                ? _value.publicProfileId
                : publicProfileId // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileImageUrl: freezed == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            genderCode: freezed == genderCode
                ? _value.genderCode
                : genderCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            ageGroupCode: freezed == ageGroupCode
                ? _value.ageGroupCode
                : ageGroupCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(
    _$UserProfileModelImpl value,
    $Res Function(_$UserProfileModelImpl) then,
  ) = __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'auth_user_id') String authUserId,
    @JsonKey(name: 'public_profile_id') String publicProfileId,
    String nickname,
    String? bio,
    @JsonKey(name: 'profile_image_url') String? profileImageUrl,
    @JsonKey(name: 'gender_code') String? genderCode,
    @JsonKey(name: 'age_group_code') String? ageGroupCode,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(
    _$UserProfileModelImpl _value,
    $Res Function(_$UserProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authUserId = null,
    Object? publicProfileId = null,
    Object? nickname = null,
    Object? bio = freezed,
    Object? profileImageUrl = freezed,
    Object? genderCode = freezed,
    Object? ageGroupCode = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserProfileModelImpl(
        authUserId: null == authUserId
            ? _value.authUserId
            : authUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        publicProfileId: null == publicProfileId
            ? _value.publicProfileId
            : publicProfileId // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileImageUrl: freezed == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        genderCode: freezed == genderCode
            ? _value.genderCode
            : genderCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        ageGroupCode: freezed == ageGroupCode
            ? _value.ageGroupCode
            : ageGroupCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl extends _UserProfileModel {
  const _$UserProfileModelImpl({
    @JsonKey(name: 'auth_user_id') required this.authUserId,
    @JsonKey(name: 'public_profile_id') required this.publicProfileId,
    required this.nickname,
    this.bio,
    @JsonKey(name: 'profile_image_url') this.profileImageUrl,
    @JsonKey(name: 'gender_code') this.genderCode,
    @JsonKey(name: 'age_group_code') this.ageGroupCode,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  }) : super._();

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  @JsonKey(name: 'auth_user_id')
  final String authUserId;
  @override
  @JsonKey(name: 'public_profile_id')
  final String publicProfileId;
  @override
  final String nickname;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'profile_image_url')
  final String? profileImageUrl;
  @override
  @JsonKey(name: 'gender_code')
  final String? genderCode;
  @override
  @JsonKey(name: 'age_group_code')
  final String? ageGroupCode;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserProfileModel(authUserId: $authUserId, publicProfileId: $publicProfileId, nickname: $nickname, bio: $bio, profileImageUrl: $profileImageUrl, genderCode: $genderCode, ageGroupCode: $ageGroupCode, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.authUserId, authUserId) ||
                other.authUserId == authUserId) &&
            (identical(other.publicProfileId, publicProfileId) ||
                other.publicProfileId == publicProfileId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.genderCode, genderCode) ||
                other.genderCode == genderCode) &&
            (identical(other.ageGroupCode, ageGroupCode) ||
                other.ageGroupCode == ageGroupCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    authUserId,
    publicProfileId,
    nickname,
    bio,
    profileImageUrl,
    genderCode,
    ageGroupCode,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(this);
  }
}

abstract class _UserProfileModel extends UserProfileModel {
  const factory _UserProfileModel({
    @JsonKey(name: 'auth_user_id') required final String authUserId,
    @JsonKey(name: 'public_profile_id') required final String publicProfileId,
    required final String nickname,
    final String? bio,
    @JsonKey(name: 'profile_image_url') final String? profileImageUrl,
    @JsonKey(name: 'gender_code') final String? genderCode,
    @JsonKey(name: 'age_group_code') final String? ageGroupCode,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$UserProfileModelImpl;
  const _UserProfileModel._() : super._();

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  @JsonKey(name: 'auth_user_id')
  String get authUserId;
  @override
  @JsonKey(name: 'public_profile_id')
  String get publicProfileId;
  @override
  String get nickname;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'profile_image_url')
  String? get profileImageUrl;
  @override
  @JsonKey(name: 'gender_code')
  String? get genderCode;
  @override
  @JsonKey(name: 'age_group_code')
  String? get ageGroupCode;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
