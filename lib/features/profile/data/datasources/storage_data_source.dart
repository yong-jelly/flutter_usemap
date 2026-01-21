import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Storage 관련 데이터 소스
class StorageDataSource {
  final SupabaseClient _supabase;
  static const String _profileBucket = 'public-profile-avatars';

  StorageDataSource(this._supabase);

  /// 프로필 이미지 업로드
  Future<String> uploadProfileImage(File file, String userId) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = file.path.split('.').last;
    final fileName = 'profile-$timestamp.$extension';
    final filePath = '$userId/$fileName';

    await _supabase.storage.from(_profileBucket).upload(
          filePath,
          file,
          fileOptions: const FileOptions(upsert: true),
        );

    // 공용 URL 반환
    return _supabase.storage.from(_profileBucket).getPublicUrl(filePath);
  }
}
