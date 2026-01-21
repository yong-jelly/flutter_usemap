import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/bookmarked_place_entity.dart';
import '../providers/profile_providers.dart';

part 'profile_saved_places_controller.g.dart';

/// 저장(북마크)한 장소 리스트 상태
class ProfileSavedPlacesState {
  final List<BookmarkedPlaceEntity> places;
  final bool hasNext;
  final bool isFetchingMore;

  const ProfileSavedPlacesState({
    required this.places,
    required this.hasNext,
    required this.isFetchingMore,
  });

  ProfileSavedPlacesState copyWith({
    List<BookmarkedPlaceEntity>? places,
    bool? hasNext,
    bool? isFetchingMore,
  }) {
    return ProfileSavedPlacesState(
      places: places ?? this.places,
      hasNext: hasNext ?? this.hasNext,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}

/// 저장(북마크)한 장소 목록을 다루는 컨트롤러
///
/// 주요 액션: 초기 로드, 추가 로드, 새로고침.
@riverpod
class ProfileSavedPlacesController extends _$ProfileSavedPlacesController {
  static const int _pageSize = 30;
  int _offset = 0;

  @override
  FutureOr<ProfileSavedPlacesState> build() async {
    _offset = 0;
    final places = await _fetchPage(limit: _pageSize, offset: _offset);
    _offset += places.length;
    return ProfileSavedPlacesState(
      places: places,
      hasNext: places.length == _pageSize,
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
          places: [...current.places, ...next],
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
      final places = await _fetchPage(limit: _pageSize, offset: _offset);
      _offset += places.length;
      return ProfileSavedPlacesState(
        places: places,
        hasNext: places.length == _pageSize,
        isFetchingMore: false,
      );
    });
  }

  Future<List<BookmarkedPlaceEntity>> _fetchPage({
    required int limit,
    required int offset,
  }) {
    final useCase = ref.read(getMyBookmarkedPlacesUseCaseProvider);
    return useCase.execute(limit: limit, offset: offset);
  }
}
