import 'package:drift/drift.dart';
import '../storage/drift_database.dart';

/// 오프라인 큐 서비스
/// 
/// 오프라인 상태에서 발생한 쓰기 작업을 큐에 저장하고,
/// 온라인 복귀 시 처리한다.
class OfflineQueueService {
  final AppDatabase _database;

  OfflineQueueService(this._database);

  /// 작업을 큐에 추가
  Future<void> enqueue(String action, String payload) async {
    await _database.into(_database.offlineQueue).insert(
          OfflineQueueCompanion.insert(
            action: action,
            payload: payload,
            isProcessed: const Value(false),
          ),
        );
  }

  /// 처리되지 않은 작업 목록 조회
  Future<List<OfflineQueueData>> getPendingItems() async {
    final query = _database.select(_database.offlineQueue)
      ..where((tbl) => tbl.isProcessed.equals(false))
      ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]);
    
    return await query.get();
  }

  /// 작업을 처리 완료로 표시
  Future<void> markAsProcessed(int id) async {
    await (_database.update(_database.offlineQueue)..where((tbl) => tbl.id.equals(id)))
        .write(const OfflineQueueCompanion(isProcessed: Value(true)));
  }

  /// 모든 처리된 작업 삭제
  Future<void> deleteProcessed() async {
    await (_database.delete(_database.offlineQueue)
          ..where((tbl) => tbl.isProcessed.equals(true)))
        .go();
  }
}
