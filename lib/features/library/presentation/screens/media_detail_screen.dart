import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';
import '../../domain/providers/library_provider.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../widgets/episode_card.dart';
import '../widgets/expandable_overview.dart';
import '../widgets/genre_chips.dart';
import '../widgets/library_error_view.dart';
import '../widgets/media_backdrop_app_bar.dart';
import '../widgets/media_meta_row.dart';
import '../widgets/media_play_button.dart';
import '../widgets/season_selector.dart';

class MediaDetailScreen extends HookConsumerWidget {
  const MediaDetailScreen({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(mediaItemDetailProvider(itemId));
    final auth = ref.watch(authenticatedStateProvider);
    final serverUrl = auth?.serverUrl ?? '';

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, _) => LibraryErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(mediaItemDetailProvider(itemId)),
        ),
        data: (item) {
          if (item.type == 'Series') {
            return _SeriesDetailBody(item: item, serverUrl: serverUrl);
          }
          return _MovieDetailBody(item: item, serverUrl: serverUrl);
        },
      ),
    );
  }
}

// ─── Movie / Episode Detail Body ──────────────────────────────────────────────

class _MovieDetailBody extends StatelessWidget {
  const _MovieDetailBody({required this.item, required this.serverUrl});

  final MediaItem item;
  final String serverUrl;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MediaBackdropAppBar(item: item, serverUrl: serverUrl),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Episode context badge
                if (item.type == 'Episode' && item.seriesName != null) ...[
                  Text(
                    item.seriesName!,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (item.parentIndexNumber != null &&
                      item.indexNumber != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 8),
                      child: Text(
                        'S${item.parentIndexNumber} · E${item.indexNumber}',
                        style: const TextStyle(
                          color: AppColors.textSecondaryDark,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
                Text(
                  item.name,
                  style: const TextStyle(
                    color: AppColors.textPrimaryDark,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                MediaMetaRow(item: item),
                const SizedBox(height: 16),
                MediaPlayButton(itemId: item.id),
                if (item.overview != null && item.overview!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: AppColors.textPrimaryDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.overview!,
                    style: const TextStyle(
                      color: AppColors.textSecondaryDark,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
                if (item.genres != null && item.genres!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  GenreChips(genres: item.genres!),
                ],
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Series Detail Body ───────────────────────────────────────────────────────

class _SeriesDetailBody extends HookConsumerWidget {
  const _SeriesDetailBody({required this.item, required this.serverUrl});

  final MediaItem item;
  final String serverUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasonsAsync = ref.watch(seasonsProvider(item.id));
    final selectedSeasonIndex = useState(0);

    return CustomScrollView(
      slivers: [
        MediaBackdropAppBar(item: item, serverUrl: serverUrl),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    color: AppColors.textPrimaryDark,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                MediaMetaRow(item: item),
                if (item.overview != null && item.overview!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ExpandableOverview(overview: item.overview!),
                ],
                if (item.genres != null && item.genres!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  GenreChips(genres: item.genres!),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        // Season selector + episodes
        seasonsAsync.when(
          loading: () => const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
          ),
          error: (e, _) => SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Failed to load seasons: $e',
                style: const TextStyle(color: AppColors.error),
              ),
            ),
          ),
          data: (seasons) {
            if (seasons.isEmpty) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No seasons found.',
                    style: TextStyle(color: AppColors.textSecondaryDark),
                  ),
                ),
              );
            }
            final seasonIdx = selectedSeasonIndex.value.clamp(
              0,
              seasons.length - 1,
            );
            final currentSeason = seasons[seasonIdx];

            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: SeasonSelector(
                    seasons: seasons,
                    selectedIndex: seasonIdx,
                    onSelected: (i) => selectedSeasonIndex.value = i,
                  ),
                ),
                _EpisodeList(
                  seriesId: item.id,
                  season: currentSeason,
                  serverUrl: serverUrl,
                ),
              ],
            );
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

// ─── Episode List ─────────────────────────────────────────────────────────────

class _EpisodeList extends ConsumerWidget {
  const _EpisodeList({
    required this.seriesId,
    required this.season,
    required this.serverUrl,
  });

  final String seriesId;
  final SeasonItem season;
  final String serverUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final episodesAsync = ref.watch(
      episodesProvider((seriesId: seriesId, seasonId: season.id)),
    );

    return episodesAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
      ),
      error: (e, _) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Failed to load episodes: $e',
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      ),
      data: (episodes) {
        if (episodes.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Text(
                'No episodes found.',
                style: TextStyle(color: AppColors.textSecondaryDark),
              ),
            ),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => EpisodeCard(
                episode: episodes[i],
                serverUrl: serverUrl,
                onTap: () => context.push('/home/detail/${episodes[i].id}'),
              ),
              childCount: episodes.length,
            ),
          ),
        );
      },
    );
  }
}
