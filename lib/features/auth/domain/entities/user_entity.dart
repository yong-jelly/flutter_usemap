import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// Supabase Auth 사용자 엔티티
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? nickname,
    String? profileImageUrl,
  }) = _UserEntity;
}
