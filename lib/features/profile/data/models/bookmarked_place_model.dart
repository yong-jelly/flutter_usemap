import '../../domain/entities/bookmarked_place_entity.dart';
import '../../domain/entities/place_feature_entity.dart';
import '../../domain/entities/place_interaction_entity.dart';

/// 저장(북마크)한 장소 모델
class BookmarkedPlaceModel {
  final String placeId;
  final Map<String, dynamic> placeData;
  final String? addedAt;

  const BookmarkedPlaceModel({
    required this.placeId,
    required this.placeData,
    this.addedAt,
  });

  factory BookmarkedPlaceModel.fromJson(Map<String, dynamic> json) {
    final placeData = (json['place_data'] as Map?)?.cast<String, dynamic>() ?? {};
    return BookmarkedPlaceModel(
      placeId: (json['place_id'] ?? placeData['id'] ?? '').toString(),
      placeData: placeData,
      addedAt: json['added_at']?.toString(),
    );
  }

  /// 도메인 엔티티로 변환함.
  BookmarkedPlaceEntity toEntity() {
    final images = _extractImages(placeData);
    final thumbnail = images.isNotEmpty ? images.first : _stringOrNull(placeData['thumbnail']);
    final interaction = _parseInteraction(placeData['interaction']);
    final features = _parseFeatures(placeData['features']);

    return BookmarkedPlaceEntity(
      placeId: placeId,
      name: _stringOrNull(placeData['name']) ?? '',
      thumbnail: thumbnail,
      group2: _stringOrNull(placeData['group2']),
      group3: _stringOrNull(placeData['group3']),
      category: _stringOrNull(placeData['category']),
      features: features,
      interaction: interaction,
    );
  }

  List<PlaceFeatureEntity> _parseFeatures(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map((item) => PlaceFeatureEntity(
              platformType: _stringOrNull(item['platform_type']) ?? '',
            ))
        .where((feature) => feature.platformType.isNotEmpty)
        .toList();
  }

  PlaceInteractionEntity? _parseInteraction(dynamic raw) {
    if (raw is! Map) return null;
    final map = raw.cast<String, dynamic>();
    return PlaceInteractionEntity(
      placeLikedCount: _intOrZero(map['place_liked_count']),
      placeReviewsCount: _intOrZero(map['place_reviews_count']),
      isSaved: map['is_saved'] == true,
    );
  }

  List<String> _extractImages(Map<String, dynamic> place) {
    final images = <String>[];
    _addImageList(images, place['images']);
    _addImageList(images, place['image_urls']);
    _addImageList(images, place['place_images']);
    if (place['thumbnail'] is String) {
      images.add(place['thumbnail'] as String);
    }
    return images.where((url) => url.trim().isNotEmpty).toList();
  }

  void _addImageList(List<String> target, dynamic raw) {
    if (raw is! List) return;
    for (final item in raw) {
      if (item is String && item.trim().isNotEmpty) {
        target.add(item);
      }
    }
  }

  String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  int _intOrZero(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
