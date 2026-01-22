// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_list_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$folderListControllerHash() =>
    r'3aae525d20f87cb0b4ab5dd3e28ffc9d7e35dc8d';

/// 공개 폴더 목록을 다루는 컨트롤러
///
/// 주요 액션: 초기 로드, 추가 로드, 새로고침.
///
/// Copied from [FolderListController].
@ProviderFor(FolderListController)
final folderListControllerProvider =
    AutoDisposeAsyncNotifierProvider<
      FolderListController,
      FolderListState
    >.internal(
      FolderListController.new,
      name: r'folderListControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$folderListControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FolderListController = AutoDisposeAsyncNotifier<FolderListState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
