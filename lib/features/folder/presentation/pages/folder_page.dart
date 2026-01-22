import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/folder_list_controller.dart';
import '../widgets/folder_card.dart';

// FolderListState 타입을 사용하기 위한 typedef
typedef _FolderState = AsyncValue<FolderListState>;

/// 폴더 화면 (추천 맛탐정)
///
/// 탐색/구독 탭으로 폴더 리스트를 제공한다.
class FolderPage extends ConsumerStatefulWidget {
  const FolderPage({super.key});

  @override
  ConsumerState<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends ConsumerState<FolderPage> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['탐색', '구독'];

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final folderState = ref.watch(folderListControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              toolbarHeight: 56,
              automaticallyImplyLeading: false,
              title: _buildHeader(),
            ),
          ];
        },
        body: _buildBody(folderState, authState),
      ),
    );
  }

  /// 헤더: 탐색/구독 탭 + 검색 아이콘
  Widget _buildHeader() {
    return Row(
      children: [
        // 탐색/구독 탭
        Expanded(
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final isSelected = _selectedTabIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTabIndex = index),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.black38,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        // 검색 아이콘 (독립된 형태)
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF5F5F5),
          ),
          child: IconButton(
            onPressed: () {
              // TODO: 검색 페이지로 이동
            },
            icon: const Icon(Icons.search, color: Colors.black87, size: 20),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  /// 본문: 탭에 따라 다른 콘텐츠 표시
  Widget _buildBody(_FolderState folderState, AsyncValue authState) {
    final isAuthenticated = authState.valueOrNull != null;

    // 구독 탭 선택 시
    if (_selectedTabIndex == 1) {
      return _buildSubscribedContent(isAuthenticated);
    }

    // 탐색 탭 (기본)
    return _buildExploreContent(folderState);
  }

  /// 탐색 탭 콘텐츠
  Widget _buildExploreContent(_FolderState folderState) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final metrics = notification.metrics;
          if (metrics.pixels >= metrics.maxScrollExtent - 200) {
            ref.read(folderListControllerProvider.notifier).fetchMore();
          }
        }
        return false;
      },
      child: folderState.when(
        data: (state) {
          final folders = state.folders.where((f) => f.placeCount > 0).toList();
          if (folders.isEmpty) {
            return const Center(
              child: Text(
                '공개된 폴더가 없습니다.',
                style: TextStyle(color: Colors.black54),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemCount: folders.length + (state.hasNext ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == folders.length) {
                return state.isFetchingMore
                    ? const Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      )
                    : const SizedBox.shrink();
              }
              return FolderCard(
                folder: folders[index],
                showOwner: true,
                onTap: () {
                  // TODO: 폴더 상세 페이지로 이동
                },
              );
            },
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.black)),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('오류가 발생했습니다', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(folderListControllerProvider),
                style: TextButton.styleFrom(foregroundColor: Colors.black87),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 구독 탭 콘텐츠
  Widget _buildSubscribedContent(bool isAuthenticated) {
    if (!isAuthenticated) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bookmark_border, size: 48, color: Colors.black26),
            const SizedBox(height: 16),
            const Text(
              '로그인하면 구독한 폴더를\n확인할 수 있습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // TODO: 로그인 페이지로 이동
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Color(0xFFD0D0D0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('로그인'),
            ),
          ],
        ),
      );
    }

    // TODO: 구독한 폴더 목록 표시
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border, size: 48, color: Colors.black26),
          SizedBox(height: 16),
          Text(
            '아직 구독한 폴더가 없습니다.',
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
