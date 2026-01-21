import 'package:flutter/material.dart';
import '../widgets/profile_edit_form.dart';

/// 프로필 편집 페이지
class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 수정'),
      ),
      body: const ProfileEditForm(),
    );
  }
}
