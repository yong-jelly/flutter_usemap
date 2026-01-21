import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/place_feature_entity.dart';
import '../../domain/entities/place_interaction_entity.dart';

/// 장소 썸네일 공통 컴포넌트
class PlaceThumbnail extends StatelessWidget {
  final String placeId;
  final String name;
  final String? thumbnail;
  final String? group2;
  final String? group3;
  final String? category;
  final List<PlaceFeatureEntity> features;
  final PlaceInteractionEntity? interaction;
  final ValueChanged<String>? onTap;
  final double aspectRatio;
  final bool rounded;
  final bool showBadge;
  final bool showUnderline;
  final bool showCounts;
  final EdgeInsets? margin;

  const PlaceThumbnail({
    super.key,
    required this.placeId,
    required this.name,
    this.thumbnail,
    this.group2,
    this.group3,
    this.category,
    this.features = const [],
    this.interaction,
    this.onTap,
    this.aspectRatio = 3 / 4,
    this.rounded = false,
    this.showBadge = true,
    this.showUnderline = true,
    this.showCounts = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final folders = _folderFeatures(features);
    final hasImage = thumbnail != null && thumbnail!.isNotEmpty;
    final borderRadius = BorderRadius.circular(rounded ? 12 : 0);

    return GestureDetector(
      onTap: () => onTap?.call(placeId),
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: borderRadius,
        ),
        clipBehavior: Clip.antiAlias,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (hasImage)
                CachedNetworkImage(
                  imageUrl: thumbnail!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildPlaceholder(),
                  errorWidget: (context, url, error) => _buildPlaceholder(),
                )
              else
                _buildPlaceholder(),
              if (showBadge && folders.isNotEmpty)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    height: 16,
                    constraints: const BoxConstraints(minWidth: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E8449),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      folders.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              _InfoOverlay(
                name: name,
                group2: group2,
                group3: group3,
                category: category,
                interaction: interaction,
                showCounts: showCounts,
                showUnderline: showUnderline,
                folderCount: folders.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF27272A),
      child: const Center(
        child: Icon(
          Icons.local_dining,
          color: Color(0x80A1A1AA),
          size: 36,
        ),
      ),
    );
  }

  List<PlaceFeatureEntity> _folderFeatures(List<PlaceFeatureEntity> items) {
    return items.where((item) => item.platformType == 'folder').toList();
  }
}

class _InfoOverlay extends StatelessWidget {
  final String name;
  final String? group2;
  final String? group3;
  final String? category;
  final PlaceInteractionEntity? interaction;
  final bool showCounts;
  final bool showUnderline;
  final int folderCount;

  const _InfoOverlay({
    required this.name,
    required this.group2,
    required this.group3,
    required this.category,
    required this.interaction,
    required this.showCounts,
    required this.showUnderline,
    required this.folderCount,
  });

  @override
  Widget build(BuildContext context) {
    final showCountsRow = (interaction?.isSaved ?? false) ||
        (showCounts &&
            ((interaction?.placeLikedCount ?? 0) +
                    (interaction?.placeReviewsCount ?? 0)) >
                0);

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xCC000000),
              Color(0x66000000),
              Color(0x00000000),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((group2?.isNotEmpty ?? false) ||
                (group3?.isNotEmpty ?? false) ||
                (category?.isNotEmpty ?? false))
              Text(
                _buildSubLine(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xCCFFFFFF),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            const SizedBox(height: 2),
            _TitleUnderline(
              name: name,
              showUnderline: showUnderline && folderCount > 0,
              folderCount: folderCount,
            ),
            if (showCountsRow) ...[
              const SizedBox(height: 2),
              _CountsRow(
                interaction: interaction,
                showCounts: showCounts,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _buildSubLine() {
    final buffer = StringBuffer();
    if (group2?.isNotEmpty ?? false) {
      buffer.write(group2);
    }
    if (group3?.isNotEmpty ?? false) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write(group3);
    }
    if ((category?.isNotEmpty ?? false) && (group2?.isNotEmpty != true)) {
      if (buffer.isNotEmpty) buffer.write(' ');
      buffer.write('#$category');
    }
    return buffer.toString();
  }
}

class _TitleUnderline extends StatelessWidget {
  final String name;
  final bool showUnderline;
  final int folderCount;

  const _TitleUnderline({
    required this.name,
    required this.showUnderline,
    required this.folderCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
        if (showUnderline)
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: Container(
              height: _underlineHeight(folderCount),
              decoration: BoxDecoration(
                color: _underlineColor(folderCount),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
      ],
    );
  }

  double _underlineHeight(int count) {
    if (count >= 15) return 2;
    if (count >= 12) return 1.8;
    if (count >= 9) return 1.5;
    if (count >= 6) return 1.2;
    if (count >= 3) return 1;
    return 0.8;
  }

  Color _underlineColor(int count) {
    if (count >= 15) return const Color(0xFF1E8449);
    if (count >= 12) return const Color(0xFF229954);
    if (count >= 9) return const Color(0xFF27AE60);
    if (count >= 6) return const Color(0xFF2ECC71);
    if (count >= 3) return const Color(0xFF52BE80);
    return const Color(0xFFABEBC6);
  }
}

class _CountsRow extends StatelessWidget {
  final PlaceInteractionEntity? interaction;
  final bool showCounts;

  const _CountsRow({
    required this.interaction,
    required this.showCounts,
  });

  @override
  Widget build(BuildContext context) {
    final likedCount = interaction?.placeLikedCount ?? 0;
    final reviewCount = interaction?.placeReviewsCount ?? 0;
    return Row(
      children: [
        if (interaction?.isSaved ?? false)
          const Padding(
            padding: EdgeInsets.only(right: 4),
            child: Icon(
              Icons.bookmark,
              size: 12,
              color: Color(0xFFFFB020),
            ),
          ),
        if (showCounts && likedCount > 0)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Row(
              children: [
                const Icon(
                  Icons.favorite,
                  size: 10,
                  color: Color(0xFFF43F5E),
                ),
                const SizedBox(width: 2),
                Text(
                  likedCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        if (showCounts && reviewCount > 0)
          Row(
            children: [
              const Icon(
                Icons.chat_bubble,
                size: 10,
                color: Colors.white,
              ),
              const SizedBox(width: 2),
              Text(
                reviewCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
