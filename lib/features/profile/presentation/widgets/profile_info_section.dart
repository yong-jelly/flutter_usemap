import 'package:flutter/material.dart';
import 'profile_retro_style.dart';

/// 프로필 정보 섹션 (이름, 비즈니스 타입, 브랜드, 웹사이트)
///
/// 사용자명 아래에 표시되는 부가 정보 영역
class ProfileInfoSection extends StatelessWidget {
  final String username;
  final String? businessType;
  final String? brandName;
  final String? website;

  const ProfileInfoSection({
    super.key,
    required this.username,
    this.businessType,
    this.brandName,
    this.website,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 사용자명
        Text(
          username,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: ProfileRetroStyle.textPrimary,
          ),
        ),
        // 비즈니스 타입
        if (businessType != null && businessType!.isNotEmpty) ...[
          const SizedBox(height: 1),
          Text(
            businessType!,
            style: TextStyle(
              fontSize: 14,
              color: ProfileRetroStyle.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        // 브랜드 이름
        if (brandName != null && brandName!.isNotEmpty) ...[
          const SizedBox(height: 1),
          Text(
            brandName!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ProfileRetroStyle.textPrimary,
            ),
          ),
        ],
        // 웹사이트
        if (website != null && website!.isNotEmpty) ...[
          const SizedBox(height: 1),
          GestureDetector(
            onTap: () {
              // TODO: 웹사이트 열기
            },
            child: Text(
              website!,
              style: const TextStyle(
                fontSize: 14,
                color: ProfileRetroStyle.accentDark,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
