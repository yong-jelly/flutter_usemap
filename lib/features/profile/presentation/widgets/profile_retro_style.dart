import 'package:flutter/material.dart';

/// 프로필 스타일 토큰
///
/// 프로필 전용 색상/라운드/섀도우를 통일 관리한다.
/// 흰색 배경 + 검은색 텍스트 기반의 깔끔한 UI.
class ProfileRetroStyle {
  ProfileRetroStyle._();

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE5E5E5);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF666666);
  static const Color accent = Color(0xFF000000);
  static const Color accentDark = Color(0xFF000000);
  static const Color highlight = Color(0xFFF5F5F5);
  static const Color tabBackground = Color(0xFFFFFFFF);
  static const Color accentPink = Color(0xFF000000);
  static const Color accentMint = Color(0xFF000000);
  static const Color accentOrange = Color(0xFF000000);
  static const Color accentYellow = Color(0xFF000000);

  static const double borderWidth = 1.0;
  static const double radius = 16;
  static const double pillRadius = 22;

  static const List<BoxShadow> cardShadow = [];
}
