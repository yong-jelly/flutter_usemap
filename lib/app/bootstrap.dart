import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/app.dart';

/// 앱 부트스트랩
/// 
/// Supabase 초기화 및 ProviderScope 설정을 수행한다.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase 초기화
  await Supabase.initialize(
    url: 'https://xyqpggpilgcdsawuvpzn.supabase.co',
    anonKey: 'sb_publishable_4rByGLkIJH0y9Qz7CKm1MA_ulfWQZtj',
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
