import 'package:go_router/go_router.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/demo/presentation/pages/main_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/auth_callback_page.dart';
import '../features/profile/presentation/pages/profile_edit_page.dart';

/// 라우트 경로 정의
class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String main = '/main';
  static const String login = '/auth/login';
  static const String authCallback = '/auth/callback';
  static const String profileEdit = '/profile/edit';
}

/// 앱 라우터 설정
final appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.main,
      name: 'main',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.authCallback,
      name: 'auth_callback',
      builder: (context, state) => const AuthCallbackPage(),
    ),
    GoRoute(
      path: AppRoutes.profileEdit,
      name: 'profile_edit',
      builder: (context, state) => const ProfileEditPage(),
    ),
  ],
);
