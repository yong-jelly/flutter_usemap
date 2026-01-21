import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/demo_form_controller.dart';
import '../controllers/demo_list_controller.dart';

/// Demo 폼 탭
/// 
/// 탭 2: 폼을 통해 데이터를 생성하고, 성공 시 리스트를 새로고침한다.
class DemoFormTab extends ConsumerWidget {
  const DemoFormTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(demoFormControllerProvider);
    final formController = ref.read(demoFormControllerProvider.notifier);
    final listController = ref.read(demoListControllerProvider.notifier);

    return formState.when(
      data: (state) => SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '새 항목 생성',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: const InputDecoration(
                labelText: '제목',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => formController.updateTitle(value),
              enabled: !state.isLoading,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: '설명',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              onChanged: (value) => formController.updateDescription(value),
              enabled: !state.isLoading,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final result = await formController.submit();
                      if (result != null) {
                        // 성공 시 리스트 새로고침
                        await listController.refresh();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('항목이 생성되었습니다'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('제목과 설명을 모두 입력해주세요'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: state.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('생성하기'),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text('오류: $error'),
      ),
    );
  }
}
