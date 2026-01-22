import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/profile_saved_places_controller.dart';
import '../../data/models/profile_mock_data.dart';
import 'profile_avatar.dart';
import 'profile_stats_section.dart';
import 'profile_info_section.dart';
import 'profile_action_buttons.dart';
import 'profile_highlights_section.dart';
import 'profile_content_tabs.dart';
import 'profile_photo_grid.dart';
import 'profile_retro_style.dart';

/// 메인 화면의 프로필 탭
///
/// Instagram 스타일의 프로필 UI를 제공한다.
class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return _buildNotLoggedIn(context);
        }
        return _buildProfileContent(context, ref);
      },
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
      error: (e, s) => Center(child: Text('상태 로드 실패: $e', style: TextStyle(color: Colors.black54))),
    );
  }

  /// 비로그인 상태 UI
  Widget _buildNotLoggedIn(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.account_circle, size: 80, color: Colors.black54),
          const SizedBox(height: 16),
          const Text(
            '로그인이 필요합니다',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '나만의 맛집 지도를 관리해보세요',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.push('/auth/login'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 56),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text('로그인하러 가기', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  /// 프로필 콘텐츠 (로그인 상태)
  Widget _buildProfileContent(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return profileAsync.when(
      data: (profile) {
        final nickname = profile?.nickname ?? 'user_name';
        final imageUrl = profile?.profileImageUrl;

        return Scaffold(
          backgroundColor: ProfileRetroStyle.background,
          appBar: _buildAppBar(nickname),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 프로필 헤더 카드
                Container(
                  margin: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ProfileRetroStyle.surface,
                    borderRadius: BorderRadius.circular(ProfileRetroStyle.radius),
                    border: Border.all(
                      color: ProfileRetroStyle.border,
                      width: ProfileRetroStyle.borderWidth,
                    ),
                    boxShadow: ProfileRetroStyle.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 프로필 헤더 섹션 (아바타 + 통계)
                      Row(
                        children: [
                          // 프로필 아바타
                          ProfileAvatar(
                            imageUrl: imageUrl,
                            fallbackText: nickname,
                            size: 86,
                            hasStory: false,
                          ),
                          const SizedBox(width: 20),
                          // 통계 섹션
                          Expanded(
                            child: ProfileStatsSection(
                              stats: ProfileMockData.stats,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 프로필 정보 섹션
                      ProfileInfoSection(
                        username: nickname,
                        businessType: ProfileMockData.businessType,
                        brandName: ProfileMockData.brandName,
                        website: ProfileMockData.website,
                      ),
                      const SizedBox(height: 16),

                      // 액션 버튼 섹션
                      ProfileActionButtons(
                        isOwnProfile: true,
                        onEditProfileTap: () => context.push('/profile/edit'),
                      ),
                    ],
                  ),
                ),

                // 하이라이트 섹션
                ProfileHighlightsSection(
                  highlights: ProfileMockData.highlights,
                  showAddButton: true,
                ),
                const SizedBox(height: 10),

                // 콘텐츠 탭
                ProfileContentTabs(
                  selectedIndex: _selectedTabIndex,
                  onTabChanged: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),

                // 콘텐츠 영역
                _buildContentArea(),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
      error: (e, s) => Center(child: Text('프로필 로드 실패: $e', style: TextStyle(color: Colors.black54))),
    );
  }

  /// 앱바 빌드
  PreferredSizeWidget _buildAppBar(String username) {
    return AppBar(
      backgroundColor: ProfileRetroStyle.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            username,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: ProfileRetroStyle.textPrimary,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: ProfileRetroStyle.textPrimary,
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add_box_outlined,
            color: ProfileRetroStyle.textPrimary,
            size: 26,
          ),
          onPressed: () {
            // TODO: 게시물 추가
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: ProfileRetroStyle.textPrimary,
            size: 26,
          ),
          onPressed: () {
            _showSettingsBottomSheet(context);
          },
        ),
      ],
    );
  }

  /// 콘텐츠 영역 (탭에 따라 다른 콘텐츠 표시)
  Widget _buildContentArea() {
    if (_selectedTabIndex == 0) {
      return _buildSavedPlacesGrid();
    } else {
      return const ProfileTaggedEmpty();
    }
  }

  Widget _buildSavedPlacesGrid() {
    final savedState = ref.watch(profileSavedPlacesControllerProvider);
    return savedState.when(
      data: (state) {
        if (state.places.isEmpty) {
          return _buildEmptySaved();
        }
        return ProfilePhotoGrid(
          places: state.places,
          onPlaceTap: (place) {
            // TODO: 장소 상세 페이지로 이동
          },
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(child: CircularProgressIndicator(color: Colors.black)),
      ),
      error: (e, s) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(child: Text('저장된 장소 로드 실패: $e', style: TextStyle(color: Colors.black54))),
      ),
    );
  }

  Widget _buildEmptySaved() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: const [
          Icon(Icons.bookmark_border, size: 56, color: ProfileRetroStyle.textSecondary),
          SizedBox(height: 12),
          Text(
            '저장한 장소가 없습니다.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: ProfileRetroStyle.textPrimary,
            ),
          ),
          SizedBox(height: 6),
          Text(
            '마음에 드는 장소를 저장해보세요.',
            style: TextStyle(color: ProfileRetroStyle.textSecondary),
          ),
        ],
      ),
    );
  }

  /// 설정 바텀시트 표시
  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ProfileRetroStyle.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ProfileRetroStyle.textSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: ProfileRetroStyle.textPrimary),
              title: const Text('설정', style: TextStyle(color: ProfileRetroStyle.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                // TODO: 설정 페이지로 이동
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_border_outlined, color: ProfileRetroStyle.textPrimary),
              title: const Text('저장됨', style: TextStyle(color: ProfileRetroStyle.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                context.push('/profile/saved');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: ProfileRetroStyle.textPrimary),
              title: const Text('활동', style: TextStyle(color: ProfileRetroStyle.textPrimary)),
              onTap: () {
                Navigator.pop(context);
                // TODO: 활동 페이지로 이동
              },
            ),
            const Divider(color: ProfileRetroStyle.border),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black54),
              title: const Text('로그아웃', style: TextStyle(color: Colors.black54)),
              onTap: () {
                Navigator.pop(context);
                ref.read(authControllerProvider.notifier).signOut();
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
