import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 피드 화면
///
/// 흰색 배경의 깔끔한 그리드 피드 UI를 제공한다.
class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = ['Explore', 'For You', 'Following'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              toolbarHeight: 56,
              title: _buildHeader(),
            ),
          ];
        },
        body: GridView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.82,
          ),
          itemCount: _feedItems.length,
          itemBuilder: (context, index) => _FeedCard(item: _feedItems[index]),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.black, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final isSelected = _selectedTabIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTabIndex = index),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.black : Colors.black38,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune, color: Colors.black, size: 22),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.item});

  final FeedItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) =>
                    Container(color: const Color(0xFFF8F8F8)),
                errorWidget: (context, url, error) => Container(
                  color: const Color(0xFFF8F8F8),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF0F0F0),
                    border: Border.all(
                      color: const Color(0xFFE8E8E8),
                      width: 0.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 14,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      letterSpacing: -0.2,
                    ),
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
    title: "'tobers of October '24 P...",
    subtitle: 'October 24',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'DATE BY DATE®',
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
    title: 'Daimler Double Six Van...',
    subtitle: 'Feature',
    imageUrl:
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Bilo - Dairy products',
    subtitle: 'Dairy products',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'Fable Whisky: The Six S...',
    subtitle: 'The Six Stories',
    imageUrl:
        'https://images.unsplash.com/photo-1470081833024-e22a4e5cf248?auto=format&fit=crop&w=800&q=80',
  ),
  FeedItem(
    title: 'CoreZero',
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
