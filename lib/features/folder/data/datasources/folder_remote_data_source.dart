import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/folder_model.dart';

/// 폴더 원격 데이터 소스
class FolderRemoteDataSource {
  final SupabaseClient _supabase;

  FolderRemoteDataSource(this._supabase);

  /// 공개 폴더 목록 조회
  Future<List<FolderModel>> getPublicFolders({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _supabase.rpc(
        'v1_list_public_folders',
        params: {
          'p_limit': limit,
          'p_offset': offset,
        },
      );

      if (response == null) return [];
      final list = response as List;
      return list
          .whereType<Map<String, dynamic>>()
          .map((json) => FolderModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 폴더 구독 토글
  Future<bool> toggleFolderSubscription(String folderId) async {
    try {
      final response = await _supabase.rpc(
        'v1_toggle_folder_subscription',
        params: {'p_folder_id': folderId},
      );

      if (response == null) return false;
      final map = response as Map<String, dynamic>;
      return map['is_subscribed'] == true;
    } catch (e) {
      return false;
    }
  }

  /// 내 구독 목록 조회
  Future<List<Map<String, dynamic>>> getMySubscriptions() async {
    try {
      final response = await _supabase.rpc('v1_list_my_subscriptions');

      if (response == null) return [];
      final list = response as List;
      return list.whereType<Map<String, dynamic>>().toList();
    } catch (e) {
      return [];
    }
  }
}
