import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../auth/data/models/user_profile_model.dart';

/// 프로필 관련 원격 데이터 소스
class ProfileRemoteDataSource {
  final SupabaseClient _supabase;

  ProfileRemoteDataSource(this._supabase);

  /// 프로필 조회
  Future<UserProfileModel?> getProfile(String authUserId) async {
    try {
      final response = await _supabase.rpc(
        'v1_get_user_profile',
        params: {'p_auth_user_id': authUserId},
      );
      
      if (response == null || (response as List).isEmpty) return null;
      
      final data = (response as List).first as Map<String, dynamic>;
      return UserProfileModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  /// 프로필 업데이트/생성
  Future<UserProfileModel> upsertProfile({
    required String nickname,
    String? bio,
    String? profileImageUrl,
  }) async {
    final response = await _supabase.rpc(
      'v2_upsert_user_profile',
      params: {
        'p_nickname': nickname,
        'p_bio': bio,
        'p_profile_image_url': profileImageUrl,
        // p_email은 RPC 내부에서 auth.email() 등으로 처리되거나 필요 시 전달
      },
    );

    if (response == null || (response as List).isEmpty) {
      throw const PostgrestException(message: '프로필 업데이트 실패');
    }

    final data = (response as List).first as Map<String, dynamic>;
    return UserProfileModel.fromJson(data);
  }
}
