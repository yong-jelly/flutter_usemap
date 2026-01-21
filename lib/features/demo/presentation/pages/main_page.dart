import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_usemap/features/demo/presentation/widgets/demo_list_tab.dart';
import 'package:flutter_usemap/features/demo/presentation/widgets/demo_form_tab.dart';
import 'package:flutter_usemap/features/profile/presentation/widgets/profile_tab.dart';

/// 메인 화면
/// 
/// 3개의 탭을 가진 화면으로, 탭 1은 리스트, 탭 2는 폼, 탭 3은 프로필을 표시한다.
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UseMap'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '리스트', icon: Icon(Icons.list)),
            Tab(text: '폼', icon: Icon(Icons.edit)),
            Tab(text: '프로필', icon: Icon(Icons.person)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const DemoListTab(),
          const DemoFormTab(),
          const ProfileTab(),
        ],
      ),
    );
  }
}
