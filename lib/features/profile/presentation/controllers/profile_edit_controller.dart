import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../presentation/providers/profile_providers.dart';
import 'profile_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

part 'profile_edit_controller.g.dart';

/// 프로필 편집 화면의 상태를 관리하는 컨트롤러
@riverpod
class ProfileEditController extends _$ProfileEditController {
  @override
  FutureOr<void> build() async {}

  /// 프로필 업데이트 실행
  Future<bool> updateProfile({
    required String nickname,
    String? bio,
    String? profileImageUrl,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final useCase = ref.read(upsertProfileUseCaseProvider);
      await useCase.execute(
        nickname: nickname,
        bio: bio,
        profileImageUrl: profileImageUrl,
      );
    });

    if (result.hasError) {
      state = AsyncValue.error(result.error!, result.stackTrace!);
      return false;
    }

    // 성공 시 프로필 정보 새로고침
    await ref.read(profileControllerProvider.notifier).refresh();
    state = const AsyncValue.data(null);
    return true;
  }

  /// 이미지 선택 및 업로드
  Future<String?> pickAndUploadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final authUser = ref.read(authControllerProvider).value;
      if (authUser == null) throw Exception('인증 정보가 없습니다.');

      final useCase = ref.read(uploadProfileImageUseCaseProvider);
      return await useCase.execute(File(image.path), authUser.id);
    });

    state = const AsyncValue.data(null);
    return result.value;
  }

  /// 랜덤 아바타 생성
  String generateRandomAvatar() {
    final seed = DateTime.now().millisecondsSinceEpoch.toString();
    return 'https://api.dicebear.com/7.x/avataaars/svg?seed=$seed';
  }
}
