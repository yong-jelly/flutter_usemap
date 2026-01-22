import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/onboarding_controller.dart';
import '../../../../router/app_router.dart';

/// 온보딩 화면
///
/// 앱 첫 실행 시 표시되는 화면으로, "시작하기" 버튼을 제공한다.
class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(onboardingControllerProvider.notifier);
    final state = ref.watch(onboardingControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: state.when(
            data: (onboardingState) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.rocket_launch, size: 120, color: Colors.black),
                const SizedBox(height: 32),
                Text(
                  '환영합니다!',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  '이 앱은 Feature-First Clean Architecture와\nRiverpod 3.x를 사용한 데모 앱입니다.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onboardingState.isLoading
                        ? null
                        : () async {
                            await controller.completeOnboarding();
                            if (context.mounted) {
                              final newState = ref.read(
                                onboardingControllerProvider,
                              );
                              newState.whenData((value) {
                                if (value.isCompleted && context.mounted) {
                                  context.go(AppRoutes.main);
                                }
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: onboardingState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('시작하기', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('오류: $error')),
          ),
        ),
      ),
    );
  }
}
