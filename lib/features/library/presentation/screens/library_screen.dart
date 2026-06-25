import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/platform_widget.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../../domain/providers/library_provider.dart';
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
        error: (e, _) => _ErrorView(
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

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondaryDark),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
