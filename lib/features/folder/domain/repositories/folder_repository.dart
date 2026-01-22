import '../entities/folder_entity.dart';

/// 폴더 레포지토리 인터페이스
abstract class FolderRepository {
  /// 공개 폴더 목록 조회 (무한 스크롤)
  Future<List<FolderEntity>> getPublicFolders({
    required int limit,
    required int offset,
  });

  /// 폴더 구독 토글
  Future<bool> toggleFolderSubscription(String folderId);

  /// 내 구독 목록 조회
  Future<List<FolderSubscriptionEntity>> getMySubscriptions();
}

/// 폴더 구독 엔티티
class FolderSubscriptionEntity {
  final String subscriptionType;
  final String featureId;
  final bool isSubscribed;

  const FolderSubscriptionEntity({
    required this.subscriptionType,
    required this.featureId,
    required this.isSubscribed,
  });
}
