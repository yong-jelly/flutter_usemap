import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/app_providers.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/sign_in_with_google_use_case.dart';
import '../../domain/usecases/sign_out_use_case.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthRemoteDataSource(supabase);
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
}

@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(SignInWithGoogleUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInWithGoogleUseCase(repository);
}

@riverpod
SignOutUseCase signOutUseCase(SignOutUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignOutUseCase(repository);
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(GetCurrentUserUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
}
