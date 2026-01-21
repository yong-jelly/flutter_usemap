import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 피드 화면
///
/// 흰색 계열의 그리드 피드 UI를 제공한다.
class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: _FeedHeader(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.86,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _FeedCard(item: _feedItems[index]),
                childCount: _feedItems.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedHeader extends StatelessWidget {
  const _FeedHeader();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          tooltip: '검색',
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Row(
            children: [
              _HeaderTab(
                label: '구독',
                isActive: true,
                textStyle: textTheme.titleMedium,
              ),
              const SizedBox(width: 16),
              _HeaderTab(
                label: '최근',
                isActive: false,
                textStyle: textTheme.titleMedium,
              ),
              const SizedBox(width: 16),
              _HeaderTab(
                label: '리뷰',
                isActive: false,
                textStyle: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderTab extends StatelessWidget {
  const _HeaderTab({
    required this.label,
    required this.isActive,
    required this.textStyle,
  });

  final String label;
  final bool isActive;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.black : const Color(0xFF9A9A9A);
    final weight = isActive ? FontWeight.w700 : FontWeight.w500;

    return Text(
      label,
      style: textStyle?.copyWith(color: color, fontWeight: weight) ??
          TextStyle(color: color, fontWeight: weight),
    );
  }
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E6E6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 1.1,
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: const Color(0xFFF0F0F0),
                ),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFFF0F0F0),
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8A8A8A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeedItem {
  const FeedItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
}

const List<FeedItem> _feedItems = [
  FeedItem(
    title: '토벌의 밤',
    subtitle: 'October 24',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'DATE BY DATE',
    subtitle: 'Collection',
    imageUrl:
        'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Solino',
    subtitle: 'Brand',
    imageUrl:
        'https://images.unsplash.com/photo-1529119368496-2dfda6ec2804?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Daimler Six',
    subtitle: 'Feature',
    imageUrl:
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Bilo',
    subtitle: 'Dairy products',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Fable Whisky',
    subtitle: 'The Six Stories',
    imageUrl:
        'https://images.unsplash.com/photo-1470081833024-e22a4e5cf248?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Core Zero',
    subtitle: 'Outdoor',
    imageUrl:
        'https://images.unsplash.com/photo-1500534314209-a26db0f5d0f3?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Landscape',
    subtitle: 'Grid',
    imageUrl:
        'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=800&q=80',
  ),
];
