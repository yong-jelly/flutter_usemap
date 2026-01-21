import '../entities/demo_entity.dart';

/// Demo Repository 인터페이스
/// 
/// 도메인 레이어에서 정의하는 인터페이스로, 구현은 data 레이어에서 한다.
abstract class DemoRepository {
  /// 현재 시간 조회 (Supabase SELECT now() 데모)
  Future<DateTime> getCurrentTime();

  /// Demo 항목 목록 조회
  Future<List<DemoEntity>> getDemoItems();

  /// Demo 항목 생성
  Future<DemoEntity> createDemoItem({
    required String title,
    required String description,
  });
}
