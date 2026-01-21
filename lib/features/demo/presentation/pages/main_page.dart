import 'package:flutter/material.dart';
import 'package:flutter_usemap/features/feed/presentation/pages/feed_page.dart';
import 'package:flutter_usemap/features/folder/presentation/pages/folder_page.dart';
import 'package:flutter_usemap/features/notifications/presentation/pages/notifications_page.dart';
import 'package:flutter_usemap/features/profile/presentation/widgets/profile_tab.dart';

/// 메인 화면
///
/// 하단 네비게이션으로 피드/폴더/알림/프로필을 제공한다.
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
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dynamic_feed_outlined),
            selectedIcon: Icon(Icons.dynamic_feed),
            label: '피드',
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: '폴더',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications),
            label: '알림',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
