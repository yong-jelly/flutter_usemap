import '../../../auth/domain/entities/user_profile_entity.dart';
import '../repositories/profile_repository.dart';

/// 프로필을 업데이트하거나 생성하는 UseCase
class UpsertProfileUseCase {
  final ProfileRepository _repository;

  UpsertProfileUseCase(this._repository);

  Future<UserProfileEntity> execute({
    required String nickname,
    String? bio,
    String? profileImageUrl,
  }) async {
    return await _repository.upsertProfile(
      nickname: nickname,
      bio: bio,
      profileImageUrl: profileImageUrl,
    );
  }
}
