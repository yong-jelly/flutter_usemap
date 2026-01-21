import 'package:flutter/material.dart';

/// 프로필 키즈-카툰 스타일 토큰
///
/// 프로필 전용 색상/라운드/섀도우를 통일 관리한다.
class ProfileRetroStyle {
  ProfileRetroStyle._();

  static const Color background = Color(0xFFF6E4C8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFF2D2A26);
  static const Color textPrimary = Color(0xFF2D2A26);
  static const Color textSecondary = Color(0xFF6C6255);
  static const Color accent = Color(0xFF66B3E5);
  static const Color accentDark = Color(0xFF235A8E);
  static const Color highlight = Color(0xFFF3D29B);
  static const Color tabBackground = Color(0xFFF9EFD8);
  static const Color accentPink = Color(0xFFE96B6B);
  static const Color accentMint = Color(0xFF4CB390);
  static const Color accentOrange = Color(0xFFF59E3D);
  static const Color accentYellow = Color(0xFFF2C34B);

  static const double borderWidth = 2.0;
  static const double radius = 16;
  static const double pillRadius = 22;

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x332D2A26),
      blurRadius: 6,
      offset: Offset(0, 3),
    ),
  ];
}
