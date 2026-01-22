import '../repositories/folder_repository.dart';

/// 폴더 구독 토글 UseCase
class ToggleFolderSubscriptionUseCase {
  const ToggleFolderSubscriptionUseCase(this._repository);

  final FolderRepository _repository;

  Future<bool> call(String folderId) async {
    return await _repository.toggleFolderSubscription(folderId);
  }
}
