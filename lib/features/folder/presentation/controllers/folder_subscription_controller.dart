import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/folder_repository.dart';
import '../providers/folder_providers.dart';

part 'folder_subscription_controller.g.dart';

/// 폴더 구독 컨트롤러
@riverpod
class FolderSubscriptionController extends _$FolderSubscriptionController {
  @override
  FutureOr<List<FolderSubscriptionEntity>> build() async {
    final useCase = ref.read(getMySubscriptionsUseCaseProvider);
    return useCase();
  }

  /// 폴더 구독 토글
  Future<void> toggleSubscription(String folderId) async {
    final current = state.valueOrNull ?? [];
    final useCase = ref.read(toggleFolderSubscriptionUseCaseProvider);

    // 낙관적 업데이트
    final updated = current.map((sub) {
      if (sub.subscriptionType == 'folder' && sub.featureId == folderId) {
        return FolderSubscriptionEntity(
          subscriptionType: sub.subscriptionType,
          featureId: sub.featureId,
          isSubscribed: !sub.isSubscribed,
        );
      }
      return sub;
    }).toList();

    state = AsyncValue.data(updated);

    try {
      final isSubscribed = await useCase(folderId);
      // 성공 시 최종 상태 반영
      final finalUpdated = current.map((sub) {
        if (sub.subscriptionType == 'folder' && sub.featureId == folderId) {
          return FolderSubscriptionEntity(
            subscriptionType: sub.subscriptionType,
            featureId: sub.featureId,
            isSubscribed: isSubscribed,
          );
        }
        return sub;
      }).toList();

      // 새로 구독한 경우 목록에 추가
      if (isSubscribed &&
          !finalUpdated.any((sub) =>
              sub.subscriptionType == 'folder' && sub.featureId == folderId)) {
        finalUpdated.insert(
          0,
          FolderSubscriptionEntity(
            subscriptionType: 'folder',
            featureId: folderId,
            isSubscribed: true,
          ),
        );
      }

      state = AsyncValue.data(finalUpdated);
    } catch (_) {
      // 에러 시 이전 상태로 복구
      state = AsyncValue.data(current);
      rethrow;
    }
  }

  /// 구독 상태 확인
  bool isSubscribed(String folderId) {
    final subscriptions = state.valueOrNull ?? [];
    return subscriptions.any((sub) =>
        sub.subscriptionType == 'folder' &&
        sub.featureId == folderId &&
        sub.isSubscribed);
  }
}
