/// Demo Entity
/// 
/// 도메인 레이어의 순수 Dart 클래스로, 외부 의존성이 없다.
class DemoEntity {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  const DemoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DemoEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      createdAt.hashCode;
}
