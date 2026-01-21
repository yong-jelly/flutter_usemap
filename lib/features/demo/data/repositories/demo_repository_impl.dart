import '../../domain/entities/demo_entity.dart';
import '../../domain/repositories/demo_repository.dart';
import '../datasources/demo_remote_data_source.dart';

/// Demo Repository 구현체
/// 
/// Data 레이어에서 도메인 인터페이스를 구현한다.
class DemoRepositoryImpl implements DemoRepository {
  final DemoRemoteDataSource _remoteDataSource;

  DemoRepositoryImpl(this._remoteDataSource);

  @override
  Future<DateTime> getCurrentTime() async {
    return await _remoteDataSource.getCurrentTime();
  }

  @override
  Future<List<DemoEntity>> getDemoItems() async {
    final models = await _remoteDataSource.getDemoItems();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<DemoEntity> createDemoItem({
    required String title,
    required String description,
  }) async {
    final model = await _remoteDataSource.createDemoItem(
      title: title,
      description: description,
    );
    return model.toEntity();
  }
}
