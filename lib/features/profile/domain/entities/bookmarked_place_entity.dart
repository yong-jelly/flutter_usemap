import 'place_feature_entity.dart';
import 'place_interaction_entity.dart';

/// 저장(북마크)한 장소 정보 엔티티
class BookmarkedPlaceEntity {
  final String placeId;
  final String name;
  final String? thumbnail;
  final String? group2;
  final String? group3;
  final String? category;
  final List<PlaceFeatureEntity> features;
  final PlaceInteractionEntity? interaction;

  const BookmarkedPlaceEntity({
    required this.placeId,
    required this.name,
    this.thumbnail,
    this.group2,
    this.group3,
    this.category,
    this.features = const [],
    this.interaction,
  });
}
