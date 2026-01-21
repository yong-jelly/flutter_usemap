import 'package:flutter/material.dart';
import 'profile_retro_style.dart';

/// 프로필 콘텐츠 탭 (그리드/태그)
///
/// Instagram 스타일의 콘텐츠 유형 선택 탭바
class ProfileContentTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTabChanged;

  const ProfileContentTabs({
    super.key,
    this.selectedIndex = 0,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: ProfileRetroStyle.tabBackground,
          borderRadius: BorderRadius.circular(ProfileRetroStyle.pillRadius),
          border: Border.all(
            color: ProfileRetroStyle.border,
            width: ProfileRetroStyle.borderWidth,
          ),
          boxShadow: ProfileRetroStyle.cardShadow,
        ),
        child: Row(
          children: [
            // 그리드 탭
            Expanded(
              child: _TabItem(
                icon: Icons.grid_on,
                isSelected: selectedIndex == 0,
                onTap: () => onTabChanged?.call(0),
              ),
            ),
            // 태그된 사진 탭
            Expanded(
              child: _TabItem(
                icon: Icons.person_pin_outlined,
                isSelected: selectedIndex == 1,
                onTap: () => onTabChanged?.call(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 개별 탭 아이템
class _TabItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const _TabItem({
    required this.icon,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 48,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? ProfileRetroStyle.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(ProfileRetroStyle.pillRadius),
          border: isSelected
              ? Border.all(
                  color: ProfileRetroStyle.border,
                  width: ProfileRetroStyle.borderWidth,
                )
              : null,
        ),
        child: Icon(
          icon,
          size: 26,
          color: isSelected ? ProfileRetroStyle.textPrimary : ProfileRetroStyle.textSecondary,
        ),
      ),
    );
  }
}
