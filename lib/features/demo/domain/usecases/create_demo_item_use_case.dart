import '../entities/demo_entity.dart';
import '../repositories/demo_repository.dart';

/// Demo 항목 생성 UseCase
class CreateDemoItemUseCase {
  final DemoRepository _repository;

  CreateDemoItemUseCase(this._repository);

  Future<DemoEntity> execute({
    required String title,
    required String description,
  }) async {
    if (title.isEmpty) {
      throw ArgumentError('제목은 필수입니다.');
    }
    if (description.isEmpty) {
      throw ArgumentError('설명은 필수입니다.');
    }
    
    return await _repository.createDemoItem(
      title: title,
      description: description,
    );
  }
}
