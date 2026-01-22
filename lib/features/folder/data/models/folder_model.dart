import '../../domain/entities/folder_entity.dart';

/// 폴더 모델 (DTO)
class FolderModel {
  final String id;
  final String ownerId;
  final String title;
  final String description;
  final String permission;
  final int permissionWriteType;
  final String? inviteCode;
  final String? inviteCodeExpiresAt;
  final int subscriberCount;
  final int placeCount;
  final bool isHidden;
  final String createdAt;
  final String updatedAt;
  final String? ownerNickname;
  final String? ownerAvatarUrl;
  final bool? isPlaceInFolder;
  final List<Map<String, dynamic>>? previewPlaces;

  const FolderModel({
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
    this.previewPlaces,
  });

  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      id: json['id']?.toString() ?? '',
      ownerId: json['owner_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      permission: json['permission']?.toString() ?? 'default',
      permissionWriteType: (json['permission_write_type'] as num?)?.toInt() ?? 0,
      inviteCode: json['invite_code']?.toString(),
      inviteCodeExpiresAt: json['invite_code_expires_at']?.toString(),
      subscriberCount: (json['subscriber_count'] as num?)?.toInt() ?? 0,
      placeCount: (json['place_count'] as num?)?.toInt() ?? 0,
      isHidden: json['is_hidden'] == true,
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      ownerNickname: json['owner_nickname']?.toString(),
      ownerAvatarUrl: json['owner_avatar_url']?.toString(),
      isPlaceInFolder: json['is_place_in_folder'] as bool?,
      previewPlaces: (json['preview_places'] as List?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }

  FolderEntity toEntity() {
    return FolderEntity(
      id: id,
      ownerId: ownerId,
      title: title,
      description: description,
      permission: _parsePermission(permission),
      permissionWriteType: permissionWriteType,
      inviteCode: inviteCode,
      inviteCodeExpiresAt: inviteCodeExpiresAt != null
          ? DateTime.tryParse(inviteCodeExpiresAt!)
          : null,
      subscriberCount: subscriberCount,
      placeCount: placeCount,
      isHidden: isHidden,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(updatedAt) ?? DateTime.now(),
      ownerNickname: ownerNickname,
      ownerAvatarUrl: ownerAvatarUrl,
      isPlaceInFolder: isPlaceInFolder,
      previewPlaces: previewPlaces
              ?.map((p) => FolderPlacePreviewEntity(
                    placeId: p['place_id']?.toString() ?? '',
                    thumbnail: p['thumbnail']?.toString() ??
                        p['images']?[0]?.toString() ??
                        p['image_urls']?[0]?.toString() ??
                        p['place_images']?[0]?.toString(),
                    score: (p['score'] as num?)?.toDouble(),
                    reviewCount: (p['review_count'] as num?)?.toInt(),
                  ))
              .toList() ??
          const [],
    );
  }

  FolderPermission _parsePermission(String permission) {
    switch (permission) {
      case 'public':
        return FolderPermission.public;
      case 'private':
        return FolderPermission.private;
      case 'hidden':
        return FolderPermission.hidden;
      case 'invite':
        return FolderPermission.invite;
      default:
        return FolderPermission.defaultValue;
    }
  }
}
