import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

/// 인증 관련 저장소 구현체
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<UserEntity?> signInWithGoogle() async {
    final user = await _remoteDataSource.signInWithGoogle();
    return _mapSupabaseUserToEntity(user);
  }

  @override
  Future<void> signOut() async {
    await _remoteDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _remoteDataSource.getCurrentUser();
    return _mapSupabaseUserToEntity(user);
  }

  @override
  Future<UserProfileEntity?> getProfile(String authUserId) async {
    final model = await _remoteDataSource.getProfile(authUserId);
    return model?.toEntity();
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _remoteDataSource.onAuthStateChange.map((authState) {
      return _mapSupabaseUserToEntity(authState.session?.user);
    });
  }

  UserEntity? _mapSupabaseUserToEntity(User? user) {
    if (user == null) return null;
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      nickname: user.userMetadata?['full_name'],
      profileImageUrl: user.userMetadata?['avatar_url'],
    );
  }
}
