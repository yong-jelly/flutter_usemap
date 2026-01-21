/// 프로필 페이지 목업 데이터
///
/// Instagram 스타일 프로필을 위한 임시 데이터 모델들
library;

/// 프로필 통계 데이터
class ProfileStats {
  final int postsCount;
  final int followersCount;
  final int followingCount;

  const ProfileStats({
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });

  /// 숫자를 축약 형식으로 변환 (예: 336000 -> "336K")
  static String formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(0)}K';
    }
    return count.toString();
  }
}

/// 하이라이트 스토리 아이템
class HighlightItem {
  final String id;
  final String title;
  final String? thumbnailUrl;

  const HighlightItem({
    required this.id,
    required this.title,
    this.thumbnailUrl,
  });
}

/// 게시물 아이템
class PostItem {
  final String id;
  final String imageUrl;
  final bool isMultiple;

  const PostItem({
    required this.id,
    required this.imageUrl,
    this.isMultiple = false,
  });
}

/// 목업 데이터 제공자
class ProfileMockData {
  ProfileMockData._();

  /// 프로필 통계 목업
  static const stats = ProfileStats(
    postsCount: 184,
    followersCount: 336000,
    followingCount: 230,
  );

  /// 하이라이트 목업 데이터
  static const highlights = [
    HighlightItem(
      id: '1',
      title: 'Highlight',
      thumbnailUrl: 'https://picsum.photos/seed/h1/200',
    ),
    HighlightItem(
      id: '2',
      title: 'Highlight',
      thumbnailUrl: 'https://picsum.photos/seed/h2/200',
    ),
    HighlightItem(
      id: '3',
      title: 'Highlight',
      thumbnailUrl: 'https://picsum.photos/seed/h3/200',
    ),
    HighlightItem(
      id: '4',
      title: 'Highlight',
      thumbnailUrl: 'https://picsum.photos/seed/h4/200',
    ),
    HighlightItem(
      id: '5',
      title: 'Highlight',
      thumbnailUrl: 'https://picsum.photos/seed/h5/200',
    ),
  ];

  /// 게시물 목업 데이터
  static final posts = List.generate(
    12,
    (index) => PostItem(
      id: 'post_$index',
      imageUrl: 'https://picsum.photos/seed/post$index/400',
      isMultiple: index % 4 == 0,
    ),
  );

  /// 브랜드/비즈니스 정보 목업
  static const businessType = 'Local Business';
  static const brandName = 'Brand Name';
  static const website = 'www.website.com';
}
