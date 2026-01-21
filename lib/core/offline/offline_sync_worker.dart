import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/drift_database.dart';
import 'offline_queue.dart';

/// 오프라인 동기화 워커
/// 
/// 온라인 상태로 복귀했을 때 큐에 쌓인 작업을 처리한다.
class OfflineSyncWorker {
  final OfflineQueueService _queueService;

  OfflineSyncWorker(this._queueService);

  /// 큐에 쌓인 작업들을 처리
  /// 
  /// 실제 구현에서는 각 action에 맞는 처리 로직을 호출한다.
  Future<void> syncPendingItems() async {
    final pendingItems = await _queueService.getPendingItems();
    
    for (final item in pendingItems) {
      try {
        // TODO: action에 따라 실제 처리 로직 호출
        // 예: await _processAction(item.action, item.payload);
        
        // 처리 완료 표시
        await _queueService.markAsProcessed(item.id);
      } catch (e) {
        // 에러 발생 시 재시도할 수 있도록 남겨둠
        // 또는 실패한 작업을 별도로 관리
      }
    }
    
    // 처리된 작업 삭제
    await _queueService.deleteProcessed();
  }
}

/// 오프라인 동기화 워커 Provider
final offlineSyncWorkerProvider = Provider<OfflineSyncWorker>((ref) {
  final database = ref.watch(appDatabaseProvider);
  final queueService = OfflineQueueService(database);
  return OfflineSyncWorker(queueService);
});

/// AppDatabase Provider
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
