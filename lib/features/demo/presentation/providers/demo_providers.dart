import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/app_providers.dart';
import '../../data/datasources/demo_remote_data_source.dart';
import '../../data/repositories/demo_repository_impl.dart';
import '../../domain/usecases/get_current_time_use_case.dart';
import '../../domain/usecases/get_demo_items_use_case.dart';
import '../../domain/usecases/create_demo_item_use_case.dart';

part 'demo_providers.g.dart';

/// Demo Remote Data Source Provider
@riverpod
DemoRemoteDataSource demoRemoteDataSource(DemoRemoteDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return DemoRemoteDataSource(supabase);
}

/// Demo Repository Provider
@riverpod
DemoRepositoryImpl demoRepository(DemoRepositoryRef ref) {
  final dataSource = ref.watch(demoRemoteDataSourceProvider);
  return DemoRepositoryImpl(dataSource);
}

/// Get Current Time UseCase Provider
@riverpod
GetCurrentTimeUseCase getCurrentTimeUseCase(GetCurrentTimeUseCaseRef ref) {
  final repository = ref.watch(demoRepositoryProvider);
  return GetCurrentTimeUseCase(repository);
}

/// Get Demo Items UseCase Provider
@riverpod
GetDemoItemsUseCase getDemoItemsUseCase(GetDemoItemsUseCaseRef ref) {
  final repository = ref.watch(demoRepositoryProvider);
  return GetDemoItemsUseCase(repository);
}

/// Create Demo Item UseCase Provider
@riverpod
CreateDemoItemUseCase createDemoItemUseCase(CreateDemoItemUseCaseRef ref) {
  final repository = ref.watch(demoRepositoryProvider);
  return CreateDemoItemUseCase(repository);
}
