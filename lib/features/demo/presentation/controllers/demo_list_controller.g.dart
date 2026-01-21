// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$demoListControllerHash() =>
    r'd6c316f234024a3d75c6be3e9698fd6f1223c973';

/// Demo 리스트 Controller
///
/// 탭 1에서 사용하는 리스트 데이터를 관리한다.
///
/// Copied from [DemoListController].
@ProviderFor(DemoListController)
final demoListControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      DemoListController,
      List<DemoEntity>
    >.internal(
      DemoListController.new,
      name: r'demoListControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$demoListControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DemoListController = AutoDisposeAsyncNotifier<List<DemoEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
