import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_controller.g.dart';

/// 온보딩 완료 상태
class OnboardingState {
  final bool isCompleted;
  final bool isLoading;

  const OnboardingState({
    this.isCompleted = false,
    this.isLoading = false,
  });

  OnboardingState copyWith({
    bool? isCompleted,
    bool? isLoading,
  }) {
    return OnboardingState(
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 온보딩 Controller
/// 
/// 온보딩 완료 상태를 관리하고, 완료 시 메인 화면으로 이동한다.
@riverpod
class OnboardingController extends _$OnboardingController {
  static const String _onboardingKey = 'onboarding_completed';

  @override
  FutureOr<OnboardingState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final isCompleted = prefs.getBool(_onboardingKey) ?? false;
    return OnboardingState(isCompleted: isCompleted);
  }

  /// 온보딩 완료 처리
  Future<void> completeOnboarding() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingKey, true);
      
      state = AsyncValue.data(
        state.value!.copyWith(
          isCompleted: true,
          isLoading: false,
        ),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
