import '../entities/demo_entity.dart';
import '../repositories/demo_repository.dart';

/// Demo 항목 목록 조회 UseCase
class GetDemoItemsUseCase {
  final DemoRepository _repository;

  GetDemoItemsUseCase(this._repository);

  Future<List<DemoEntity>> execute() async {
    return await _repository.getDemoItems();
  }
}
