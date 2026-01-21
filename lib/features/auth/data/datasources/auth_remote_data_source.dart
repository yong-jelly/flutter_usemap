import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_profile_model.dart';

/// 인증 관련 원격 데이터 소스
class AuthRemoteDataSource {
  final SupabaseClient _supabase;

  AuthRemoteDataSource(this._supabase);

  /// Google 로그인 (플랫폼별 처리)
  Future<User?> signInWithGoogle() async {
    if (kIsWeb) {
      // 웹: OAuth redirect 방식
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: '${Uri.base.origin}/auth/callback',
      );
      return null; // Redirect 방식이므로 이후 흐름은 콜백 페이지에서 처리
    } else {
      // 모바일: Native Google Sign In
      // iOS는 Supabase 대시보드에서 'Skip nonce checks'를 활성화해야 함
      final googleSignIn = GoogleSignIn(
        // iOS: Client ID를 Info.plist에 설정해야 함
        // Android: Client ID를 설정하지 않아도 됨 (SHA-1 기반)
        // 웹용 Client ID (Native Google Sign-In 사용 시 ID Token 검증용으로 필요할 수 있음)
        serverClientId: '739607551455-5j178o6ferb5eg31cah4iln18bs1tfdn.apps.googleusercontent.com',
      );
      
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw const AuthException('Google ID Token을 찾을 수 없습니다.');
      }

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      return response.user;
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    await _supabase.auth.signOut();
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }
  }

  /// 현재 사용자 조회
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// 사용자 상세 프로필 조회 (RPC)
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
      // 프로필이 없는 경우 null 반환 (PGRST116 등)
      return null;
    }
  }

  /// 인증 상태 변경 스트림
  Stream<AuthState> get onAuthStateChange => _supabase.auth.onAuthStateChange;
}
