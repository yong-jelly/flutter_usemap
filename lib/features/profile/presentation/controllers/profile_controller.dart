import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/domain/entities/user_profile_entity.dart';
import '../../presentation/providers/profile_providers.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

part 'profile_controller.g.dart';

/// 사용자 프로필 정보를 관리하는 컨트롤러
@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<UserProfileEntity?> build() async {
    final authUser = await ref.watch(authControllerProvider.future);
    if (authUser == null) return null;

    final useCase = ref.watch(getProfileUseCaseProvider);
    return await useCase.execute(authUser.id);
  }

  /// 프로필 정보를 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final authUser = ref.read(authControllerProvider).value;
      if (authUser == null) return null;
      
      final useCase = ref.read(getProfileUseCaseProvider);
      return await useCase.execute(authUser.id);
    });
  }
}
