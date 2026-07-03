import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/platform_widget.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../../domain/providers/library_provider.dart';
import '../widgets/continue_watching_card.dart';
import '../widgets/library_card.dart';
import '../widgets/library_error_view.dart';

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
          icon: const Icon(
            Icons.logout_rounded,
            color: AppColors.textSecondaryDark,
          ),
          tooltip: 'Logout',
          onPressed: () => ref.read(authProvider.notifier).logout(),
        ),
      ],
      body: viewsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => LibraryErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(userViewsProvider),
        ),
        data: (libraries) {
          if (libraries.isEmpty) {
            return const Center(
              child: Text(
                'No libraries found.',
                style: TextStyle(
                  color: AppColors.textSecondaryDark,
                  decoration: TextDecoration.none,
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              // ── Greeting ───────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Text(
                    'Hello, ${auth?.username ?? 'there'}',
                    style: const TextStyle(
                      color: AppColors.textSecondaryDark,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),

              // ── Library Grid ───────────────────────────────────────────
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: Text(
                    'Your Libraries',
                    style: TextStyle(
                      color: AppColors.textPrimaryDark,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 16 / 10,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final lib = libraries[index];
                    return LibraryCard(
                      library: lib,
                      serverUrl: auth?.serverUrl ?? '',
                      onTap: () => context.push(
                        '/home/library/${lib.id}',
                        extra: lib.name,
                      ),
                    );
                  }, childCount: libraries.length),
                ),
              ),
              // ── Continue Watching ──────────────────────────────────────
              ..._continueWatchingSlivers(context, ref, auth?.serverUrl ?? ''),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
    );
  }

  /// Builds the "Continue Watching" header + horizontal row.
  /// Returns an empty list when there is nothing in progress.
  List<Widget> _continueWatchingSlivers(
    BuildContext context,
    WidgetRef ref,
    String serverUrl,
  ) {
    final resumeAsync = ref.watch(continueWatchingProvider);
    final items = resumeAsync.value ?? const [];
    if (items.isEmpty) return const [];

    return [
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Text(
            'Continue Watching',
            style: TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 165,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return ContinueWatchingCard(
                item: item,
                serverUrl: serverUrl,
                onTap: () async {
                  await context.push('/home/player/${item.id}');
                  // Refresh progress/list after returning from the player.
                  ref.invalidate(continueWatchingProvider);
                },
              );
            },
          ),
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 28)),
    ];
  }
}
