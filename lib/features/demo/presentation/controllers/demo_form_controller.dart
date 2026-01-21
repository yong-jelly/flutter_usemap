import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/demo_providers.dart';
import '../../domain/entities/demo_entity.dart';

part 'demo_form_controller.g.dart';

/// Demo 폼 상태
class DemoFormState {
  final String title;
  final String description;
  final bool isLoading;

  const DemoFormState({
    this.title = '',
    this.description = '',
    this.isLoading = false,
  });

  DemoFormState copyWith({
    String? title,
    String? description,
    bool? isLoading,
  }) {
    return DemoFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Demo 폼 Controller
/// 
/// 탭 2에서 사용하는 폼 상태와 제출 로직을 관리한다.
@riverpod
class DemoFormController extends _$DemoFormController {
  @override
  FutureOr<DemoFormState> build() {
    return const DemoFormState();
  }

  /// 제목 업데이트
  void updateTitle(String title) {
    state = AsyncValue.data(state.value!.copyWith(title: title));
  }

  /// 설명 업데이트
  void updateDescription(String description) {
    state = AsyncValue.data(state.value!.copyWith(description: description));
  }

  /// 폼 제출
  Future<DemoEntity?> submit() async {
    final currentState = state.value!;
    
    if (currentState.title.isEmpty || currentState.description.isEmpty) {
      return null;
    }

    state = AsyncValue.data(currentState.copyWith(isLoading: true));

    try {
      final useCase = ref.read(createDemoItemUseCaseProvider);
      final entity = await useCase.execute(
        title: currentState.title,
        description: currentState.description,
      );

      // 폼 초기화
      state = const AsyncValue.data(DemoFormState());

      return entity;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }
}
