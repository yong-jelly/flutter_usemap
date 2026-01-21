import 'package:flutter/material.dart';
import 'profile_retro_style.dart';

/// 프로필 액션 버튼 섹션 (Follow, Message, Email, 더보기)
///
/// Instagram 스타일의 프로필 액션 버튼들
class ProfileActionButtons extends StatelessWidget {
  final bool isFollowing;
  final bool isOwnProfile;
  final VoidCallback? onFollowTap;
  final VoidCallback? onMessageTap;
  final VoidCallback? onEmailTap;
  final VoidCallback? onMoreTap;
  final VoidCallback? onEditProfileTap;

  const ProfileActionButtons({
    super.key,
    this.isFollowing = false,
    this.isOwnProfile = false,
    this.onFollowTap,
    this.onMessageTap,
    this.onEmailTap,
    this.onMoreTap,
    this.onEditProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    // 자신의 프로필인 경우
    if (isOwnProfile) {
      return _buildOwnProfileButtons(context);
    }
    
    // 다른 사용자 프로필인 경우
    return _buildOtherProfileButtons(context);
  }

  /// 자신의 프로필 버튼 (프로필 편집, 프로필 공유)
  Widget _buildOwnProfileButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            label: '프로필 편집',
            isPrimary: false,
            onTap: onEditProfileTap,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionButton(
            label: '프로필 공유',
            isPrimary: false,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  /// 다른 사용자 프로필 버튼 (Follow, Message, Email, 더보기)
  Widget _buildOtherProfileButtons(BuildContext context) {
    return Row(
      children: [
        // Follow 버튼
        Expanded(
          child: _ActionButton(
            label: isFollowing ? 'Following' : 'Follow',
            isPrimary: !isFollowing,
            onTap: onFollowTap,
          ),
        ),
        const SizedBox(width: 6),
        // Message 버튼
        Expanded(
          child: _ActionButton(
            label: 'Message',
            isPrimary: false,
            onTap: onMessageTap,
          ),
        ),
        const SizedBox(width: 6),
        // Email 버튼
        Expanded(
          child: _ActionButton(
            label: 'Email',
            isPrimary: false,
            onTap: onEmailTap,
          ),
        ),
        const SizedBox(width: 6),
        // 더보기 버튼
        _MoreButton(onTap: onMoreTap),
      ],
    );
  }
}

/// 액션 버튼 위젯
class _ActionButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    this.isPrimary = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isPrimary ? ProfileRetroStyle.accent : ProfileRetroStyle.surface;
    final textColor =
        isPrimary ? ProfileRetroStyle.accentDark : ProfileRetroStyle.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ProfileRetroStyle.pillRadius),
        child: Ink(
          height: 42,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(ProfileRetroStyle.pillRadius),
            border: Border.all(
              color: ProfileRetroStyle.border,
              width: ProfileRetroStyle.borderWidth,
            ),
            boxShadow: ProfileRetroStyle.cardShadow,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 더보기 버튼 (드롭다운 아이콘)
class _MoreButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _MoreButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ProfileRetroStyle.pillRadius),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: ProfileRetroStyle.surface,
            borderRadius: BorderRadius.circular(ProfileRetroStyle.pillRadius),
            border: Border.all(
              color: ProfileRetroStyle.border,
              width: ProfileRetroStyle.borderWidth,
            ),
            boxShadow: ProfileRetroStyle.cardShadow,
          ),
          child: const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: ProfileRetroStyle.textPrimary,
          ),
        ),
      ),
    );
  }
}
