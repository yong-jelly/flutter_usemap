import 'dart:io';
import '../../../auth/domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/bookmarked_place_entity.dart';
import '../datasources/profile_remote_data_source.dart';
import '../datasources/storage_data_source.dart';

/// 프로필 저장소 구현체
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;
  final StorageDataSource _storageDataSource;

  ProfileRepositoryImpl(this._remoteDataSource, this._storageDataSource);

  @override
  Future<UserProfileEntity?> getProfile(String authUserId) async {
    final model = await _remoteDataSource.getProfile(authUserId);
    return model?.toEntity();
  }

  @override
  Future<UserProfileEntity> upsertProfile({
    required String nickname,
    String? bio,
    String? profileImageUrl,
  }) async {
    final model = await _remoteDataSource.upsertProfile(
      nickname: nickname,
      bio: bio,
      profileImageUrl: profileImageUrl,
    );
    return model.toEntity();
  }

  @override
  Future<String> uploadProfileImage(File file, String userId) async {
    return await _storageDataSource.uploadProfileImage(file, userId);
  }

  @override
  Future<List<BookmarkedPlaceEntity>> getMyBookmarkedPlaces({
    int limit = 20,
    int offset = 0,
  }) async {
    final models = await _remoteDataSource.getMyBookmarkedPlaces(
      limit: limit,
      offset: offset,
    );
    return models.map((model) => model.toEntity()).toList();
  }
}
