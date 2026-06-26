import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/platform_widget.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../../domain/providers/library_provider.dart';
import '../widgets/library_error_view.dart';
import '../widgets/media_item_card.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({
    super.key,
    required this.libraryId,
    required this.libraryName,
  });

  final String libraryId;
  final String libraryName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authenticatedStateProvider);
    final itemsAsync = ref.watch(libraryItemsProvider(libraryId));

    return AdaptiveScaffold(
      title: libraryName,
      padding: EdgeInsets.zero,
      body: itemsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => LibraryErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(libraryItemsProvider(libraryId)),
        ),
        data: (state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Text(
                'No items in this library.',
                style: TextStyle(
                  color: AppColors.textSecondaryDark,
                  decoration: TextDecoration.none,
                ),
              ),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter < 300) {
                ref.read(libraryItemsProvider(libraryId).notifier).loadMore();
              }
              return false;
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      '${state.items.length} of ${state.totalCount} items',
                      style: const TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 13,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.58,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = state.items[index];
                      return MediaItemCard(
                        item: item,
                        serverUrl: auth?.serverUrl ?? '',
                        onTap: () => context.push('/home/detail/${item.id}'),
                      );
                    }, childCount: state.items.length),
                  ),
                ),
                if (state.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          );
        },
      ),
    );
  }
}
