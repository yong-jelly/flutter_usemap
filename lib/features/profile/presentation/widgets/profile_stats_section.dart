import 'package:flutter/material.dart';
import '../../data/models/profile_mock_data.dart';
import 'profile_retro_style.dart';

/// 프로필 통계 섹션 (Posts, Followers, Following)
///
/// Instagram 스타일의 프로필 통계를 표시한다.
class ProfileStatsSection extends StatelessWidget {
  final ProfileStats stats;
  final VoidCallback? onPostsTap;
  final VoidCallback? onFollowersTap;
  final VoidCallback? onFollowingTap;

  const ProfileStatsSection({
    super.key,
    required this.stats,
    this.onPostsTap,
    this.onFollowersTap,
    this.onFollowingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(
          count: stats.postsCount,
          label: 'Posts',
          onTap: onPostsTap,
        ),
        _StatItem(
          count: stats.followersCount,
          label: 'Followers',
          onTap: onFollowersTap,
        ),
        _StatItem(
          count: stats.followingCount,
          label: 'Following',
          onTap: onFollowingTap,
        ),
      ],
    );
  }
}

/// 개별 통계 아이템
class _StatItem extends StatelessWidget {
  final int count;
  final String label;
  final VoidCallback? onTap;

  const _StatItem({
    required this.count,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ProfileStats.formatCount(count),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: ProfileRetroStyle.textPrimary,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: ProfileRetroStyle.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
