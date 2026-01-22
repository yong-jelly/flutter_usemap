import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_usemap/features/feed/presentation/pages/feed_page.dart';
import 'package:flutter_usemap/features/folder/presentation/pages/folder_page.dart';
import 'package:flutter_usemap/features/notifications/presentation/pages/notifications_page.dart';
import 'package:flutter_usemap/features/profile/presentation/widgets/profile_tab.dart';

/// 메인 화면
///
/// iOS 26 Liquid Glass 스타일 하단 네비게이션으로 피드/폴더/알림/프로필을 제공한다.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const _pages = [
    FeedPage(),
    FolderPage(),
    NotificationsPage(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        useNativeBottomBar: true, // minimize behavior 비활성화
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          AdaptiveNavigationDestination(icon: 'square.grid.2x2', label: '피드'),
          AdaptiveNavigationDestination(icon: 'folder', label: '폴더'),
          AdaptiveNavigationDestination(icon: 'bell', label: '알림'),
          AdaptiveNavigationDestination(icon: 'person', label: '프로필'),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
