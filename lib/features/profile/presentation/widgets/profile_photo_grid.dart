import 'package:flutter/material.dart';
import '../../domain/entities/bookmarked_place_entity.dart';
import 'place_thumbnail.dart';
import 'profile_retro_style.dart';

/// 프로필 사진 그리드
///
/// Instagram 스타일의 3열 사진 그리드
class ProfilePhotoGrid extends StatelessWidget {
  final List<BookmarkedPlaceEntity> places;
  final void Function(BookmarkedPlaceEntity)? onPlaceTap;

  const ProfilePhotoGrid({
    super.key,
    required this.places,
    this.onPlaceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: ProfileRetroStyle.surface,
        borderRadius: BorderRadius.circular(ProfileRetroStyle.radius),
        border: Border.all(
          color: ProfileRetroStyle.border,
          width: ProfileRetroStyle.borderWidth,
        ),
        boxShadow: ProfileRetroStyle.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ProfileRetroStyle.radius),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return PlaceThumbnail(
              placeId: place.placeId,
              name: place.name,
              thumbnail: place.thumbnail,
              group2: place.group2,
              group3: place.group3,
              category: place.category,
              features: place.features,
              interaction: place.interaction,
              onTap: (_) => onPlaceTap?.call(place),
            );
          },
        ),
      ),
    );
  }
}

/// 태그된 사진 빈 상태
class ProfileTaggedEmpty extends StatelessWidget {
  const ProfileTaggedEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ProfileRetroStyle.border,
                width: 2.5,
              ),
              color: ProfileRetroStyle.highlight,
            ),
            child: const Icon(
              Icons.person_pin_outlined,
              size: 40,
              color: ProfileRetroStyle.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Photos of you',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ProfileRetroStyle.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When people tag you in photos, they\'ll appear here.',
            style: TextStyle(
              fontSize: 14,
              color: ProfileRetroStyle.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
