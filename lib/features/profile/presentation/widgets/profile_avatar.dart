import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_retro_style.dart';

/// Instagram 스타일 프로필 아바타
///
/// 프로필 상단에 표시되는 원형 프로필 이미지
/// 그라데이션 테두리(스토리가 있는 경우) 또는 일반 테두리 지원
class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String fallbackText;
  final double size;
  final bool hasStory;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    required this.fallbackText,
    this.size = 86,
    this.hasStory = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: hasStory
              ? const LinearGradient(
                  colors: [
                    ProfileRetroStyle.highlight,
                    ProfileRetroStyle.accent,
                    ProfileRetroStyle.accentPink,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )
              : null,
          border: !hasStory
              ? Border.all(
                  color: ProfileRetroStyle.border,
                  width: ProfileRetroStyle.borderWidth,
                )
              : null,
          boxShadow: ProfileRetroStyle.cardShadow,
        ),
        padding: EdgeInsets.all(hasStory ? 4 : 0),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ProfileRetroStyle.surface,
            border: hasStory
                ? Border.all(
                    color: ProfileRetroStyle.surface,
                    width: 3,
                  )
                : null,
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildFallback();
    }

    // SVG 이미지 처리
    if (imageUrl!.contains('/svg') || imageUrl!.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl!,
        fit: BoxFit.cover,
        placeholderBuilder: (context) => _buildLoading(),
      );
    }

    // 일반 이미지 처리
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      placeholder: (context, url) => _buildLoading(),
      errorWidget: (context, url, error) => _buildFallback(),
    );
  }

  Widget _buildLoading() {
    return Container(
      color: ProfileRetroStyle.highlight,
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      color: ProfileRetroStyle.highlight,
      child: Center(
        child: Text(
          fallbackText.isNotEmpty ? fallbackText[0].toUpperCase() : '?',
          style: TextStyle(
            fontSize: size * 0.35,
            fontWeight: FontWeight.bold,
            color: ProfileRetroStyle.textSecondary,
          ),
        ),
      ),
    );
  }
}
