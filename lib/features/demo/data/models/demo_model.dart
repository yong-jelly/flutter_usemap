import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/demo_entity.dart';

part 'demo_model.g.dart';

/// Demo Model (DTO)
/// 
/// Supabase에서 받아온 데이터를 매핑한다.
@JsonSerializable()
class DemoModel {
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  const DemoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory DemoModel.fromJson(Map<String, dynamic> json) =>
      _$DemoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DemoModelToJson(this);

  /// Entity로 변환
  DemoEntity toEntity() {
    return DemoEntity(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
    );
  }

  /// Entity로부터 생성
  factory DemoModel.fromEntity(DemoEntity entity) {
    return DemoModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }
}
