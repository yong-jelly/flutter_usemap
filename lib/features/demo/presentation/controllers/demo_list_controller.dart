import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/demo_entity.dart';
import '../providers/demo_providers.dart';

part 'demo_list_controller.g.dart';

/// Demo 리스트 Controller
/// 
/// 탭 1에서 사용하는 리스트 데이터를 관리한다.
@riverpod
class DemoListController extends _$DemoListController {
  @override
  FutureOr<List<DemoEntity>> build() async {
    final useCase = ref.read(getDemoItemsUseCaseProvider);
    return await useCase.execute();
  }

  /// 리스트 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(getDemoItemsUseCaseProvider);
      return await useCase.execute();
    });
  }
}
