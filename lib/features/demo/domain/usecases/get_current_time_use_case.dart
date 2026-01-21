import '../repositories/demo_repository.dart';

/// 현재 시간 조회 UseCase
/// 
/// Supabase의 SELECT now() 쿼리를 실행한다.
class GetCurrentTimeUseCase {
  final DemoRepository _repository;

  GetCurrentTimeUseCase(this._repository);

  Future<DateTime> execute() async {
    return await _repository.getCurrentTime();
  }
}
