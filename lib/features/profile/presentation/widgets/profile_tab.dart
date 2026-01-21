import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../widgets/profile_header.dart';

/// 메인 화면의 프로필 탭
class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          // 비로그인 상태
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle, size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  '로그인이 필요합니다',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('나만의 맛집 지도를 관리해보세요'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => context.push('/auth/login'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text('로그인하러 가기', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          );
        }

        // 로그인 상태
        return const SingleChildScrollView(
          child: ProfileHeader(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('상태 로드 실패: $e')),
    );
  }
}
