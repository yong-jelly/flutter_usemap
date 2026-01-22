import '../repositories/folder_repository.dart';

/// 내 구독 목록 조회 UseCase
class GetMySubscriptionsUseCase {
  const GetMySubscriptionsUseCase(this._repository);

  final FolderRepository _repository;

  Future<List<FolderSubscriptionEntity>> call() async {
    return await _repository.getMySubscriptions();
  }
}
