import 'package:flutter/material.dart';

/// 폴더 화면
///
/// 저장된 콘텐츠를 위한 기본 화면이다.
class FolderPage extends StatelessWidget {
  const FolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          '폴더',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
