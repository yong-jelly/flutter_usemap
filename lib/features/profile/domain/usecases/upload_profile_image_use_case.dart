import 'dart:io';
import '../repositories/profile_repository.dart';

/// 프로필 이미지를 업로드하는 UseCase
class UploadProfileImageUseCase {
  final ProfileRepository _repository;

  UploadProfileImageUseCase(this._repository);

  Future<String> execute(File file, String userId) async {
    return await _repository.uploadProfileImage(file, userId);
  }
}
