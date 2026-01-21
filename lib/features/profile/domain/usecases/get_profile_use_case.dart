import '../../../auth/domain/entities/user_profile_entity.dart';
import '../repositories/profile_repository.dart';

/// 프로필을 조회하는 UseCase
class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<UserProfileEntity?> execute(String authUserId) async {
    return await _repository.getProfile(authUserId);
  }
}
