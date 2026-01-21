import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

/// 프로필 헤더 위젯
class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileControllerProvider);

    return profileAsync.when(
      data: (profile) {
        if (profile == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // 프로필 이미지
                  _ProfileAvatar(
                    imageUrl: profile.profileImageUrl,
                    nickname: profile.nickname,
                  ),
                  const SizedBox(width: 20),
                  // 사용자 정보
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.nickname,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profile.bio ?? '소개 정보가 없습니다.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // 프로필 편집 버튼
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => context.push('/profile/edit'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: const Text(
                    '프로필 편집',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // 로그아웃 버튼
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.logout, color: Colors.grey),
                ),
                title: const Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () => ref.read(authControllerProvider.notifier).signOut(),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('프로필 로드 실패: $e')),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String nickname;

  const _ProfileAvatar({this.imageUrl, required this.nickname});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: 48,
        backgroundColor: Colors.grey[200],
        child: Text(
          nickname.isNotEmpty ? nickname[0].toUpperCase() : '?',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
    }

    if (imageUrl!.contains('/svg') || imageUrl!.endsWith('.svg')) {
      return Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[100]!, width: 4),
        ),
        clipBehavior: Clip.antiAlias,
        child: SvgPicture.network(
          imageUrl!,
          fit: BoxFit.cover,
          placeholderBuilder: (context) => const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[100]!, width: 4),
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
