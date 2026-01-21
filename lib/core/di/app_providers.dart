import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase 클라이언트 Provider
/// 
/// 앱 전체에서 사용하는 Supabase 클라이언트를 제공한다.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});
