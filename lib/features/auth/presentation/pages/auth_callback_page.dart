import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/app_router.dart';
import '../controllers/auth_controller.dart';

/// 웹 OAuth 콜백 처리를 위한 페이지
class AuthCallbackPage extends ConsumerStatefulWidget {
  const AuthCallbackPage({super.key});

  @override
  ConsumerState<AuthCallbackPage> createState() => _AuthCallbackPageState();
}

class _AuthCallbackPageState extends ConsumerState<AuthCallbackPage> {
  @override
  void initState() {
    super.initState();
    _handleAuthCallback();
  }

  Future<void> _handleAuthCallback() async {
    // 잠시 기다린 후 메인 화면으로 이동
    // Supabase SDK가 내부적으로 세션을 처리함
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      context.go(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('인증 처리 중...'),
          ],
        ),
      ),
    );
  }
}
