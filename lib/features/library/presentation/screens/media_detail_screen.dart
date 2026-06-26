import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';
import '../../domain/providers/library_provider.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../widgets/jellyfin_image.dart';

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
        error: (e, _) => _ErrorBody(
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
        _BackdropAppBar(item: item, serverUrl: serverUrl),
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
                _MetaRow(item: item),
                const SizedBox(height: 16),
                _PlayButton(itemId: item.id),
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
                  _GenreChips(genres: item.genres!),
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
        _BackdropAppBar(item: item, serverUrl: serverUrl),
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
                _MetaRow(item: item),
                if (item.overview != null && item.overview!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _ExpandableOverview(overview: item.overview!),
                ],
                if (item.genres != null && item.genres!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _GenreChips(genres: item.genres!),
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
                // Season selector tabs
                SliverToBoxAdapter(
                  child: _SeasonSelector(
                    seasons: seasons,
                    selectedIndex: seasonIdx,
                    onSelected: (i) => selectedSeasonIndex.value = i,
                  ),
                ),
                // Episode list
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

// ─── Season Selector ──────────────────────────────────────────────────────────

class _SeasonSelector extends StatelessWidget {
  const _SeasonSelector({
    required this.seasons,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<SeasonItem> seasons;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: seasons.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final season = seasons[i];
          final isSelected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.cardDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                season.name,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : AppColors.textSecondaryDark,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
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
              (context, i) => _EpisodeCard(
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

// ─── Episode Card ─────────────────────────────────────────────────────────────

class _EpisodeCard extends StatelessWidget {
  const _EpisodeCard({
    required this.episode,
    required this.serverUrl,
    required this.onTap,
  });

  final EpisodeItem episode;
  final String serverUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasThumb =
        episode.imageTags != null && episode.imageTags!.containsKey('Primary');
    final runtime = episode.runTimeTicks != null
        ? _formatRuntime(episode.runTimeTicks!)
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
              child: SizedBox(
                width: 140,
                height: 110,
                child: hasThumb
                    ? Image.network(
                        jellyfinImageUrl(
                          serverUrl,
                          episode.id,
                          imageType: 'Primary',
                          tag: episode.imageTags!['Primary'],
                          maxHeight: 170,
                        ),
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            _EpisodeThumbnailPlaceholder(),
                      )
                    : _EpisodeThumbnailPlaceholder(),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (episode.indexNumber != null)
                      Text(
                        'E${episode.indexNumber}',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    const SizedBox(height: 2),
                    Text(
                      episode.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimaryDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    if (runtime != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        runtime,
                        style: const TextStyle(
                          color: AppColors.textSecondaryDark,
                          fontSize: 11,
                        ),
                      ),
                    ],
                    if (episode.overview != null &&
                        episode.overview!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        episode.overview!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSecondaryDark,
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondaryDark,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRuntime(int ticks) {
    final minutes = (ticks / 600000000).round();
    if (minutes < 60) return '${minutes}m';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }
}

class _EpisodeThumbnailPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      child: const Center(
        child: Icon(
          Icons.play_circle_outline_rounded,
          color: AppColors.textSecondaryDark,
          size: 28,
        ),
      ),
    );
  }
}

// ─── Backdrop App Bar ─────────────────────────────────────────────────────────

class _BackdropAppBar extends StatelessWidget {
  const _BackdropAppBar({required this.item, required this.serverUrl});

  final MediaItem item;
  final String serverUrl;

  @override
  Widget build(BuildContext context) {
    final hasBackdrop =
        item.backdropImageTags != null && item.backdropImageTags!.isNotEmpty;
    final hasPoster =
        item.imageTags != null && item.imageTags!.containsKey('Primary');

    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Backdrop or poster
            if (hasBackdrop)
              Image.network(
                jellyfinImageUrl(
                  serverUrl,
                  item.id,
                  imageType: 'Backdrop',
                  tag: item.backdropImageTags!.first,
                  maxHeight: 480,
                ),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _BackdropPlaceholder(),
              )
            else if (hasPoster)
              Image.network(
                jellyfinImageUrl(
                  serverUrl,
                  item.id,
                  imageType: 'Primary',
                  tag: item.imageTags!['Primary'],
                  maxHeight: 480,
                ),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _BackdropPlaceholder(),
              )
            else
              _BackdropPlaceholder(),
            // Gradient overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 1.0],
                  colors: [Colors.transparent, AppColors.backgroundDark],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackdropPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      child: const Center(
        child: Icon(
          Icons.movie_rounded,
          color: AppColors.textSecondaryDark,
          size: 48,
        ),
      ),
    );
  }
}

// ─── Meta Row ─────────────────────────────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.item});

  final MediaItem item;

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];
    if (item.productionYear != null) parts.add('${item.productionYear}');
    if (item.officialRating != null) parts.add(item.officialRating!);
    if (item.runTimeTicks != null) {
      final minutes = (item.runTimeTicks! / 600000000).round();
      if (minutes < 60) {
        parts.add('${minutes}m');
      } else {
        final h = minutes ~/ 60;
        final m = minutes % 60;
        parts.add(m == 0 ? '${h}h' : '${h}h ${m}m');
      }
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (item.communityRating != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star_rounded,
                color: AppColors.warning,
                size: 16,
              ),
              const SizedBox(width: 3),
              Text(
                item.communityRating!.toStringAsFixed(1),
                style: const TextStyle(
                  color: AppColors.textPrimaryDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        for (final part in parts)
          Text(
            part,
            style: const TextStyle(
              color: AppColors.textSecondaryDark,
              fontSize: 13,
            ),
          ),
      ],
    );
  }
}

// ─── Play Button ──────────────────────────────────────────────────────────────

class _PlayButton extends StatelessWidget {
  const _PlayButton({required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => context.push('/home/player/$itemId'),
        icon: const Icon(Icons.play_arrow_rounded, size: 22),
        label: const Text(
          'Play',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ─── Expandable Overview ──────────────────────────────────────────────────────

class _ExpandableOverview extends HookWidget {
  const _ExpandableOverview({required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);

    return GestureDetector(
      onTap: () => expanded.value = !expanded.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            firstChild: Text(
              overview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            secondChild: Text(
              overview,
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            crossFadeState: expanded.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
          const SizedBox(height: 4),
          Text(
            expanded.value ? 'Show less' : 'Read more',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Genre Chips ──────────────────────────────────────────────────────────────

class _GenreChips extends StatelessWidget {
  const _GenreChips({required this.genres});

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: genres
          .map(
            (g) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                g,
                style: const TextStyle(
                  color: AppColors.textSecondaryDark,
                  fontSize: 12,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─── Error Body ───────────────────────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

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
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onRetry,
              child: const Text(
                'Retry',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
