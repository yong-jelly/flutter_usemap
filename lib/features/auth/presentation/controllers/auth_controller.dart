import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user_entity.dart';
import '../providers/auth_providers.dart';

part 'auth_controller.g.dart';

/// 인증 상태와 로직을 관리하는 컨트롤러
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<UserEntity?> build() async {
    final useCase = ref.watch(getCurrentUserUseCaseProvider);
    final user = await useCase.execute();
    
    // 인증 상태 변경을 구독하여 자동으로 state 업데이트
    ref.listen(authRepositoryProvider, (previous, next) {
      // Repository에서 authStateChanges 스트림을 처리하도록 구현했으므로,
      // 여기서는 필요한 경우 추가 처리를 할 수 있음.
      // 간단히 하기 위해 build에서 직접 초기 사용자를 가져오고,
      // 스트림은 별도의 Provider에서 관리할 수 있음.
    });

    return user;
  }

  /// Google 로그인 실행
  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(signInWithGoogleUseCaseProvider);
      return await useCase.execute();
    });
  }

  /// 로그아웃 실행
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() async {
      final useCase = ref.read(signOutUseCaseProvider);
      await useCase.execute();
      return null;
    });
    state = const AsyncValue.data(null);
  }
}

/// 인증 상태 스트림을 제공하는 Provider
@riverpod
Stream<UserEntity?> authState(AuthStateRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
}
