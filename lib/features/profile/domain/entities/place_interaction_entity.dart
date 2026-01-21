/// 장소 인터랙션 정보 엔티티
class PlaceInteractionEntity {
  final int placeLikedCount;
  final int placeReviewsCount;
  final bool isSaved;

  const PlaceInteractionEntity({
    required this.placeLikedCount,
    required this.placeReviewsCount,
    required this.isSaved,
  });
}
