import '../repositories/auth_repository.dart';

/// 로그아웃을 수행하는 UseCase
class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> execute() async {
    await _repository.signOut();
  }
}
