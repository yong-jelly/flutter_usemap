import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/app_providers.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/datasources/storage_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_profile_use_case.dart';
import '../../domain/usecases/get_my_bookmarked_places_use_case.dart';
import '../../domain/usecases/upload_profile_image_use_case.dart';
import '../../domain/usecases/upsert_profile_use_case.dart';

part 'profile_providers.g.dart';

@riverpod
ProfileRemoteDataSource profileRemoteDataSource(ProfileRemoteDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return ProfileRemoteDataSource(supabase);
}

@riverpod
StorageDataSource storageDataSource(StorageDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return StorageDataSource(supabase);
}

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  final remoteDS = ref.watch(profileRemoteDataSourceProvider);
  final storageDS = ref.watch(storageDataSourceProvider);
  return ProfileRepositoryImpl(remoteDS, storageDS);
}

@riverpod
GetProfileUseCase getProfileUseCase(GetProfileUseCaseRef ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetProfileUseCase(repository);
}

@riverpod
UpsertProfileUseCase upsertProfileUseCase(UpsertProfileUseCaseRef ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpsertProfileUseCase(repository);
}

@riverpod
UploadProfileImageUseCase uploadProfileImageUseCase(UploadProfileImageUseCaseRef ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UploadProfileImageUseCase(repository);
}

@riverpod
GetMyBookmarkedPlacesUseCase getMyBookmarkedPlacesUseCase(GetMyBookmarkedPlacesUseCaseRef ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetMyBookmarkedPlacesUseCase(repository);
}
