import 'package:flutter/material.dart';
import '../core/ui/app_theme.dart';
import '../router/app_router.dart';

/// 앱 루트 위젯
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Demo 앱',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
