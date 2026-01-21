import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Google 로그인을 수행하는 UseCase
class SignInWithGoogleUseCase {
  final AuthRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<UserEntity?> execute() async {
    return await _repository.signInWithGoogle();
  }
}
