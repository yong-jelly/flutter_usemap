import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data/models/profile_mock_data.dart';
import 'profile_retro_style.dart';

/// 프로필 하이라이트 스토리 섹션
///
/// 가로 스크롤 가능한 원형 하이라이트 아이템 목록
class ProfileHighlightsSection extends StatelessWidget {
  final List<HighlightItem> highlights;
  final bool showAddButton;
  final void Function(HighlightItem)? onHighlightTap;
  final VoidCallback? onAddTap;

  const ProfileHighlightsSection({
    super.key,
    required this.highlights,
    this.showAddButton = false,
    this.onHighlightTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: ProfileRetroStyle.tabBackground,
        borderRadius: BorderRadius.circular(ProfileRetroStyle.radius),
        border: Border.all(
          color: ProfileRetroStyle.border,
          width: ProfileRetroStyle.borderWidth,
        ),
        boxShadow: ProfileRetroStyle.cardShadow,
      ),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: highlights.length + (showAddButton ? 1 : 0),
          itemBuilder: (context, index) {
            // 첫 번째 아이템: 추가 버튼 (자신의 프로필인 경우)
            if (showAddButton && index == 0) {
              return _AddHighlightButton(onTap: onAddTap);
            }

            final highlightIndex = showAddButton ? index - 1 : index;
            final highlight = highlights[highlightIndex];

            return _HighlightItem(
              highlight: highlight,
              onTap: () => onHighlightTap?.call(highlight),
            );
          },
        ),
      ),
    );
  }
}

/// 개별 하이라이트 아이템
class _HighlightItem extends StatelessWidget {
  final HighlightItem highlight;
  final VoidCallback? onTap;

  const _HighlightItem({
    required this.highlight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 하이라이트 썸네일 (테두리 포함)
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ProfileRetroStyle.border,
                  width: ProfileRetroStyle.borderWidth,
                ),
                color: ProfileRetroStyle.highlight,
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: highlight.thumbnailUrl != null
                    ? CachedNetworkImage(
                        imageUrl: highlight.thumbnailUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: ProfileRetroStyle.highlight,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: ProfileRetroStyle.highlight,
                          child: const Icon(Icons.image, color: ProfileRetroStyle.textSecondary),
                        ),
                      )
                    : Container(
                        color: ProfileRetroStyle.highlight,
                        child: const Icon(Icons.image, color: ProfileRetroStyle.textSecondary),
                      ),
              ),
            ),
            const SizedBox(height: 6),
            // 하이라이트 제목
            Text(
              highlight.title,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: ProfileRetroStyle.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// 하이라이트 추가 버튼
class _AddHighlightButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _AddHighlightButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ProfileRetroStyle.border,
                  width: ProfileRetroStyle.borderWidth,
                ),
                color: ProfileRetroStyle.highlight,
              ),
              child: Icon(
                Icons.add,
                size: 32,
                color: ProfileRetroStyle.textSecondary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'New',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: ProfileRetroStyle.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
