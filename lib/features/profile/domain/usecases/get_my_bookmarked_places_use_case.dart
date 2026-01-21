import '../entities/bookmarked_place_entity.dart';
import '../repositories/profile_repository.dart';

/// 저장(북마크)한 장소 목록을 조회한다.
class GetMyBookmarkedPlacesUseCase {
  final ProfileRepository _repository;

  GetMyBookmarkedPlacesUseCase(this._repository);

  /// 저장된 장소 목록 조회 실행.
  Future<List<BookmarkedPlaceEntity>> execute({
    int limit = 20,
    int offset = 0,
  }) {
    return _repository.getMyBookmarkedPlaces(
      limit: limit,
      offset: offset,
    );
  }
}
