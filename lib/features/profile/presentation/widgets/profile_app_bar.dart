import 'package:flutter/material.dart';

/// 프로필 앱바
///
/// Instagram 스타일의 프로필 페이지 상단 앱바
class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final bool isOwnProfile;
  final VoidCallback? onBackTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMenuTap;

  const ProfileAppBar({
    super.key,
    required this.username,
    this.isOwnProfile = false,
    this.onBackTap,
    this.onNotificationTap,
    this.onMenuTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: onBackTap != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: onBackTap,
            )
          : null,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            username,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (isOwnProfile) ...[
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: Colors.black87,
            ),
          ],
        ],
      ),
      centerTitle: false,
      actions: [
        // 알림 버튼
        IconButton(
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.black87,
            size: 26,
          ),
          onPressed: onNotificationTap,
        ),
        // 메뉴 버튼
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black87, size: 26),
          onPressed: onMenuTap,
        ),
      ],
    );
  }
}
