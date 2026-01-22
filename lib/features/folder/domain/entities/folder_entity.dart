/// 폴더 권한 타입
enum FolderPermission {
  public,
  private,
  hidden,
  invite,
  defaultValue,
}

/// 폴더 엔티티
class FolderEntity {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final FolderPermission permission;
  final int permissionWriteType;
  final String? inviteCode;
  final DateTime? inviteCodeExpiresAt;
  final int subscriberCount;
  final int placeCount;
  final bool isHidden;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? ownerNickname;
  final String? ownerAvatarUrl;
  final bool? isPlaceInFolder;
  final List<FolderPlacePreviewEntity> previewPlaces;

  const FolderEntity({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.permission,
    required this.permissionWriteType,
    this.inviteCode,
    this.inviteCodeExpiresAt,
    required this.subscriberCount,
    required this.placeCount,
    required this.isHidden,
    required this.createdAt,
    required this.updatedAt,
    this.ownerNickname,
    this.ownerAvatarUrl,
    this.isPlaceInFolder,
    this.previewPlaces = const [],
  });
}

/// 폴더 내 장소 미리보기 엔티티
class FolderPlacePreviewEntity {
  final String placeId;
  final String? thumbnail;
  final double? score;
  final int? reviewCount;

  const FolderPlacePreviewEntity({
    required this.placeId,
    this.thumbnail,
    this.score,
    this.reviewCount,
  });
}
