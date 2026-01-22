import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../controllers/profile_controller.dart';
import '../controllers/profile_edit_controller.dart';

/// 프로필 편집 폼 위젯
class ProfileEditForm extends ConsumerStatefulWidget {
  const ProfileEditForm({super.key});

  @override
  ConsumerState<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends ConsumerState<ProfileEditForm> {
  final _nicknameController = TextEditingController();
  final _bioController = TextEditingController();
  String? _profileImageUrl;
  bool _initialized = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _initFields() {
    final profile = ref.read(profileControllerProvider).value;
    if (profile != null && !_initialized) {
      _nicknameController.text = profile.nickname;
      _bioController.text = profile.bio ?? '';
      _profileImageUrl = profile.profileImageUrl;
      _initialized = true;
    }
  }

  Future<void> _handleImagePick() async {
    final url = await ref.read(profileEditControllerProvider.notifier).pickAndUploadImage();
    if (url != null) {
      setState(() => _profileImageUrl = url);
    }
  }

  void _handleRandomAvatar() {
    final url = ref.read(profileEditControllerProvider.notifier).generateRandomAvatar();
    setState(() => _profileImageUrl = url);
  }

  Future<void> _handleSubmit() async {
    final success = await ref.read(profileEditControllerProvider.notifier).updateProfile(
          nickname: _nicknameController.text,
          bio: _bioController.text,
          profileImageUrl: _profileImageUrl,
        );
    if (success && mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _initFields();
    final editState = ref.watch(profileEditControllerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // 프로필 이미지 섹션
          Center(
            child: Stack(
              children: [
                _AvatarPreview(imageUrl: _profileImageUrl),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _handleImagePick,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: _handleRandomAvatar,
            icon: const Icon(Icons.refresh, color: Colors.black54),
            label: const Text(
              '랜덤 아바타',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(height: 32),
          // 닉네임 입력
          TextField(
            controller: _nicknameController,
            decoration: const InputDecoration(
              labelText: '닉네임',
              border: OutlineInputBorder(),
              hintText: '닉네임을 입력하세요',
            ),
          ),
          const SizedBox(height: 20),
          // 소개 입력
          TextField(
            controller: _bioController,
            decoration: const InputDecoration(
              labelText: '소개',
              border: OutlineInputBorder(),
              hintText: '자신을 소개해주세요',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 40),
          // 저장 버튼
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: editState.isLoading ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: editState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('저장하기', style: TextStyle(fontSize: 18)),
            ),
          ),
          if (editState.hasError) ...[
            const SizedBox(height: 16),
            Text(
              '저장 실패: ${editState.error}',
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }
}

class _AvatarPreview extends StatelessWidget {
  final String? imageUrl;

  const _AvatarPreview({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    const double size = 120;
    
    Widget imageWidget;
    if (imageUrl == null || imageUrl!.isEmpty) {
      imageWidget = const Icon(Icons.person, size: 60, color: Colors.grey);
    } else if (imageUrl!.contains('/svg') || imageUrl!.endsWith('.svg')) {
      imageWidget = SvgPicture.network(
        imageUrl!,
        fit: BoxFit.cover,
        placeholderBuilder: (context) => const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageWidget,
    );
  }
}
