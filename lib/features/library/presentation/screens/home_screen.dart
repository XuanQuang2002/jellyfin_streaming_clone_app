import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/platform_widget.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../../domain/providers/library_provider.dart';
import '../widgets/library_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authenticatedStateProvider);
    final viewsAsync = ref.watch(userViewsProvider);

    return AdaptiveScaffold(
      title: 'My Media',
      padding: EdgeInsets.zero,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_rounded, color: AppColors.textSecondaryDark),
          tooltip: 'Logout',
          onPressed: () => ref.read(authProvider.notifier).logout(),
        ),
      ],
      body: viewsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => _ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(userViewsProvider),
        ),
        data: (libraries) {
          if (libraries.isEmpty) {
            return const Center(
              child: Text(
                'No libraries found.',
                style: TextStyle(color: AppColors.textSecondaryDark),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // ── Greeting ───────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${auth?.username ?? 'there'}',
                        style: const TextStyle(
                          color: AppColors.textSecondaryDark,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Your Libraries',
                        style: TextStyle(
                          color: AppColors.textPrimaryDark,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ── Library Grid ───────────────────────────────────────────
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 16 / 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final lib = libraries[index];
                      return LibraryCard(
                        library: lib,
                        serverUrl: auth?.serverUrl ?? '',
                        onTap: () => context.push(
                          '/home/library/${lib.id}',
                          extra: lib.name,
                        ),
                      );
                    },
                    childCount: libraries.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
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
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
