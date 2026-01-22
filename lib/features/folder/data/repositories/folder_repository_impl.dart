import '../../domain/entities/folder_entity.dart';
import '../../domain/repositories/folder_repository.dart';
import '../datasources/folder_remote_data_source.dart';
import '../models/folder_model.dart';

/// 폴더 레포지토리 구현체
class FolderRepositoryImpl implements FolderRepository {
  const FolderRepositoryImpl(this._remoteDataSource);

  final FolderRemoteDataSource _remoteDataSource;

  @override
  Future<List<FolderEntity>> getPublicFolders({
    required int limit,
    required int offset,
  }) async {
    final models = await _remoteDataSource.getPublicFolders(
      limit: limit,
      offset: offset,
    );
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<bool> toggleFolderSubscription(String folderId) async {
    return await _remoteDataSource.toggleFolderSubscription(folderId);
  }

  @override
  Future<List<FolderSubscriptionEntity>> getMySubscriptions() async {
    final data = await _remoteDataSource.getMySubscriptions();
    return data
        .map((item) => FolderSubscriptionEntity(
              subscriptionType: item['subscription_type']?.toString() ?? '',
              featureId: item['feature_id']?.toString() ?? '',
              isSubscribed: item['is_subscribed'] == true,
            ))
        .toList();
  }
}
