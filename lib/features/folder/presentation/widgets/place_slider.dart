import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/folder_entity.dart';

/// 장소 슬라이더 위젯
class PlaceSlider extends StatelessWidget {
  const PlaceSlider({
    super.key,
    required this.places,
    this.onPlaceTap,
    this.onMoreTap,
    this.showMoreThreshold = 5,
  });

  final List<FolderPlacePreviewEntity> places;
  final void Function(FolderPlacePreviewEntity place)? onPlaceTap;
  final VoidCallback? onMoreTap;
  final int showMoreThreshold;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemCount: places.length + (places.length >= showMoreThreshold ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == places.length) {
            return _buildMoreButton();
          }
          return _buildPlaceItem(places[index]);
        },
      ),
    );
  }

  Widget _buildPlaceItem(FolderPlacePreviewEntity place) {
    return GestureDetector(
      onTap: () => onPlaceTap?.call(place),
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: place.thumbnail != null
                  ? CachedNetworkImage(
                      imageUrl: place.thumbnail!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Container(
                        color: const Color(0xFFF8F8F8),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: const Color(0xFFF8F8F8),
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.black26,
                        ),
                      ),
                    )
                  : Container(
                      color: const Color(0xFFF8F8F8),
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.black26,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreButton() {
    return GestureDetector(
      onTap: onMoreTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E5E5)),
          color: Colors.white,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_forward, color: Colors.black38),
              SizedBox(height: 4),
              Text(
                '더보기',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
