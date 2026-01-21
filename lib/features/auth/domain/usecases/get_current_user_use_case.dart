import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// 현재 인증된 사용자를 조회하는 UseCase
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UserEntity?> execute() async {
    return await _repository.getCurrentUser();
  }
}
