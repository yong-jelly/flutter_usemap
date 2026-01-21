import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/ui/widgets/loading_widget.dart';
import '../../../../core/ui/widgets/error_widget.dart';
import '../controllers/demo_list_controller.dart';
import '../../domain/entities/demo_entity.dart';

/// Demo 리스트 탭
/// 
/// 탭 1: 데이터 리스트를 표시하고 새로고침 기능을 제공한다.
class DemoListTab extends ConsumerWidget {
  const DemoListTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(demoListControllerProvider);
    final controller = ref.read(demoListControllerProvider.notifier);

    return RefreshIndicator(
      onRefresh: () => controller.refresh(),
      child: state.when(
        data: (items) => items.isEmpty
            ? const Center(
                child: Text('데이터가 없습니다'),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _DemoItemCard(item: items[index]);
                },
              ),
        loading: () => const LoadingWidget(),
        error: (error, stackTrace) => ErrorDisplayWidget(
          error: error,
          stackTrace: stackTrace,
          onRetry: () => controller.refresh(),
        ),
      ),
    );
  }
}

class _DemoItemCard extends StatelessWidget {
  final DemoEntity item;

  const _DemoItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.description),
        trailing: Text(
          '${item.createdAt.year}-${item.createdAt.month.toString().padLeft(2, '0')}-${item.createdAt.day.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
