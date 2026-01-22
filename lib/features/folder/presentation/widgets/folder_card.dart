import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/folder_entity.dart';
import '../controllers/folder_subscription_controller.dart';
import 'place_slider.dart';

/// 폴더 카드 위젯
class FolderCard extends ConsumerWidget {
  const FolderCard({
    super.key,
    required this.folder,
    this.showOwner = false,
    this.hideSubscribeButton = false,
    this.onTap,
  });

  final FolderEntity folder;
  final bool showOwner;
  final bool hideSubscribeButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(folderSubscriptionControllerProvider);
    final isSubscribed = subscriptionState.valueOrNull
            ?.any((sub) =>
                sub.subscriptionType == 'folder' &&
                sub.featureId == folder.id &&
                sub.isSubscribed) ??
        false;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 영역: 프로필 + 타이틀 + 구독 버튼
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showOwner) ...[
                  _buildOwnerAvatar(),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: onTap,
                              child: Text(
                                folder.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          if (!hideSubscribeButton) ...[
                            Builder(
                              builder: (context) {
                                final currentUser = ref.read(authControllerProvider).valueOrNull;
                                if (currentUser != null && currentUser.id == folder.ownerId) {
                                  return const SizedBox.shrink();
                                }
                                return _buildSubscribeButton(ref, isSubscribed);
                              },
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      _buildMetadata(context),
                    ],
                  ),
                ),
              ],
            ),
            // 설명
            if (folder.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                folder.description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // 장소 슬라이더
            if (folder.previewPlaces.isNotEmpty) ...[
              const SizedBox(height: 12),
              PlaceSlider(
                places: folder.previewPlaces,
                onPlaceTap: (place) {
                  // TODO: 장소 상세 페이지로 이동
                },
                onMoreTap: onTap,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerAvatar() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF0F0F0),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 0.5),
        ),
        child: folder.ownerAvatarUrl != null
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: folder.ownerAvatarUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.black38,
                  ),
                ),
              )
            : const Icon(
                Icons.person,
                size: 20,
                color: Colors.black38,
              ),
      ),
    );
  }

  Widget _buildMetadata(BuildContext context) {
    return Row(
      children: [
        if (showOwner) ...[
          Text(
            folder.ownerNickname ?? '익명',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '•',
            style: TextStyle(fontSize: 10, color: Colors.black26),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          '${folder.placeCount.toLocaleString()}개 매장',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black38,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '•',
          style: TextStyle(fontSize: 10, color: Colors.black26),
        ),
        const SizedBox(width: 8),
        Row(
          children: [
            const Icon(Icons.access_time, size: 12, color: Colors.black38),
            const SizedBox(width: 4),
            Text(
              _formatUpdateDate(context),
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubscribeButton(WidgetRef ref, bool isSubscribed) {
    // AdaptiveButton은 Row 내부에서 unbounded width 문제 발생
    // (iOS26 UiKitView가 SizedBox.expand 사용)
    // 기본 Flutter 버튼 사용
    return SizedBox(
      height: 28,
      child: isSubscribed
          ? TextButton(
              onPressed: () async {
                await ref
                    .read(folderSubscriptionControllerProvider.notifier)
                    .toggleSubscription(folder.id);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                backgroundColor: Colors.black.withOpacity(0.08),
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                '구독중',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            )
          : OutlinedButton(
              onPressed: () async {
                await ref
                    .read(folderSubscriptionControllerProvider.notifier)
                    .toggleSubscription(folder.id);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                foregroundColor: Colors.black87,
                side: const BorderSide(color: Color(0xFFD0D0D0)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                '구독',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
    );
  }

  String _formatUpdateDate(BuildContext context) {
    final date = folder.updatedAt;
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 7) {
      return DateFormat('yy.M.d').format(date);
    } else if (diff.inDays > 0) {
      return '${diff.inDays}일 전';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}시간 전';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
}

extension NumberFormatting on int {
  String toLocaleString() {
    return NumberFormat('#,###').format(this);
  }
}
