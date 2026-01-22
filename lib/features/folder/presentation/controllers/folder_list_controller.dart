import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/folder_entity.dart';
import '../providers/folder_providers.dart';

part 'folder_list_controller.g.dart';

/// 폴더 리스트 상태
class FolderListState {
  final List<FolderEntity> folders;
  final bool hasNext;
  final bool isFetchingMore;

  const FolderListState({
    required this.folders,
    required this.hasNext,
    required this.isFetchingMore,
  });

  FolderListState copyWith({
    List<FolderEntity>? folders,
    bool? hasNext,
    bool? isFetchingMore,
  }) {
    return FolderListState(
      folders: folders ?? this.folders,
      hasNext: hasNext ?? this.hasNext,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}

/// 공개 폴더 목록을 다루는 컨트롤러
///
/// 주요 액션: 초기 로드, 추가 로드, 새로고침.
@riverpod
class FolderListController extends _$FolderListController {
  static const int _pageSize = 20;
  int _offset = 0;

  @override
  FutureOr<FolderListState> build() async {
    _offset = 0;
    final folders = await _fetchPage(limit: _pageSize, offset: _offset);
    _offset += folders.length;
    return FolderListState(
      folders: folders,
      hasNext: folders.length == _pageSize,
      isFetchingMore: false,
    );
  }

  /// 다음 페이지를 로드한다.
  Future<void> fetchMore() async {
    final current = state.valueOrNull;
    if (current == null || current.isFetchingMore || !current.hasNext) return;

    state = AsyncValue.data(current.copyWith(isFetchingMore: true));
    try {
      final next = await _fetchPage(limit: _pageSize, offset: _offset);
      _offset += next.length;

      state = AsyncValue.data(
        current.copyWith(
          folders: [...current.folders, ...next],
          hasNext: next.length == _pageSize,
          isFetchingMore: false,
        ),
      );
    } catch (_) {
      state = AsyncValue.data(current.copyWith(isFetchingMore: false));
    }
  }

  /// 전체 목록을 다시 불러온다.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    _offset = 0;
    state = await AsyncValue.guard(() async {
      final folders = await _fetchPage(limit: _pageSize, offset: _offset);
      _offset += folders.length;
      return FolderListState(
        folders: folders,
        hasNext: folders.length == _pageSize,
        isFetchingMore: false,
      );
    });
  }

  Future<List<FolderEntity>> _fetchPage({
    required int limit,
    required int offset,
  }) {
    final useCase = ref.read(getPublicFoldersUseCaseProvider);
    return useCase(limit: limit, offset: offset);
  }
}
