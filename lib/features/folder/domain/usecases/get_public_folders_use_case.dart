import '../entities/folder_entity.dart';
import '../repositories/folder_repository.dart';

/// 공개 폴더 목록 조회 UseCase
class GetPublicFoldersUseCase {
  const GetPublicFoldersUseCase(this._repository);

  final FolderRepository _repository;

  Future<List<FolderEntity>> call({
    required int limit,
    required int offset,
  }) async {
    return await _repository.getPublicFolders(
      limit: limit,
      offset: offset,
    );
  }
}
