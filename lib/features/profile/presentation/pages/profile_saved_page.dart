import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/profile_saved_places_controller.dart';
import '../widgets/place_thumbnail.dart';
import '../widgets/profile_retro_style.dart';

/// 저장된 장소 목록 페이지
class ProfileSavedPage extends ConsumerStatefulWidget {
  const ProfileSavedPage({super.key});

  @override
  ConsumerState<ProfileSavedPage> createState() => _ProfileSavedPageState();
}

class _ProfileSavedPageState extends ConsumerState<ProfileSavedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      ref.read(profileSavedPlacesControllerProvider.notifier).fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(profileSavedPlacesControllerProvider);

    return Scaffold(
      backgroundColor: ProfileRetroStyle.background,
      appBar: AppBar(
        title: const Text('저장됨'),
        backgroundColor: ProfileRetroStyle.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: stateAsync.when(
        data: (state) {
          if (state.places.isEmpty) {
            return _buildEmpty();
          }
          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 3 / 4,
            ),
            itemCount: state.places.length + (state.hasNext ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.places.length) {
                return state.isFetchingMore
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink();
              }
              final place = state.places[index];
              return PlaceThumbnail(
                placeId: place.placeId,
                name: place.name,
                thumbnail: place.thumbnail,
                group2: place.group2,
                group3: place.group3,
                category: place.category,
                features: place.features,
                interaction: place.interaction,
                onTap: (_) {
                  // TODO: 장소 상세 페이지로 이동
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(
          child: Text('저장된 장소 로드 실패: $e'),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.bookmark_border, size: 60, color: ProfileRetroStyle.textSecondary),
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
}
