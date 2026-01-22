import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/app_providers.dart';
import '../../data/datasources/folder_remote_data_source.dart';
import '../../data/repositories/folder_repository_impl.dart';
import '../../domain/repositories/folder_repository.dart';
import '../../domain/usecases/get_public_folders_use_case.dart';
import '../../domain/usecases/toggle_folder_subscription_use_case.dart';
import '../../domain/usecases/get_my_subscriptions_use_case.dart';

part 'folder_providers.g.dart';

/// 폴더 원격 데이터 소스 Provider
@riverpod
FolderRemoteDataSource folderRemoteDataSource(
  FolderRemoteDataSourceRef ref,
) {
  final supabase = ref.watch(supabaseClientProvider);
  return FolderRemoteDataSource(supabase);
}

/// 폴더 레포지토리 Provider
@riverpod
FolderRepository folderRepository(FolderRepositoryRef ref) {
  final dataSource = ref.watch(folderRemoteDataSourceProvider);
  return FolderRepositoryImpl(dataSource);
}

/// 공개 폴더 목록 조회 UseCase Provider
@riverpod
GetPublicFoldersUseCase getPublicFoldersUseCase(
  GetPublicFoldersUseCaseRef ref,
) {
  final repository = ref.watch(folderRepositoryProvider);
  return GetPublicFoldersUseCase(repository);
}

/// 폴더 구독 토글 UseCase Provider
@riverpod
ToggleFolderSubscriptionUseCase toggleFolderSubscriptionUseCase(
  ToggleFolderSubscriptionUseCaseRef ref,
) {
  final repository = ref.watch(folderRepositoryProvider);
  return ToggleFolderSubscriptionUseCase(repository);
}

/// 내 구독 목록 조회 UseCase Provider
@riverpod
GetMySubscriptionsUseCase getMySubscriptionsUseCase(
  GetMySubscriptionsUseCaseRef ref,
) {
  final repository = ref.watch(folderRepositoryProvider);
  return GetMySubscriptionsUseCase(repository);
}
