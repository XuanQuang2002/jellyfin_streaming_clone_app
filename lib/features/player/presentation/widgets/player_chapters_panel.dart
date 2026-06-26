import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../data/models/player_model.dart';
import '../../domain/providers/player_provider.dart';
import 'player_panel_sheet.dart';

class PlayerChaptersPanel extends ConsumerWidget {
  const PlayerChaptersPanel({
    super.key,
    required this.player,
    required this.itemId,
    required this.serverUrl,
    required this.onClose,
  });

  final Player player;
  final String itemId;
  final String serverUrl;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(playerItemDetailProvider(itemId));

    return PlayerPanelSheet(
      title: 'Chapters',
      onClose: onClose,
      child: detailAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (_, _) => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.white24,
                size: 36,
              ),
              SizedBox(height: 8),
              Text(
                'Failed to load chapters',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ],
          ),
        ),
        data: (detail) {
          if (detail.chapters.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.format_list_bulleted_rounded,
                    color: Colors.white24,
                    size: 40,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No chapters available',
                    style: TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                ],
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              // Card width derived from panel height so cards fill the available height
              final cardWidth = constraints.maxHeight;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                itemCount: detail.chapters.length,
                itemBuilder: (context, i) {
                  final chapter = detail.chapters[i];
                  final isLast = i == detail.chapters.length - 1;
                  final endTicks = isLast
                      ? (detail.runTimeTicks ?? chapter.startPositionTicks)
                      : detail.chapters[i + 1].startPositionTicks;
                  final startDur = _ticksToDuration(chapter.startPositionTicks);

                  return _ChapterCard(
                    width: cardWidth,
                    chapter: chapter,
                    index: i,
                    startDuration: startDur,
                    endDuration: _ticksToDuration(endTicks),
                    serverUrl: serverUrl,
                    itemId: itemId,
                    onTap: () => player.seek(startDur),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  static Duration _ticksToDuration(int ticks) =>
      Duration(microseconds: ticks ~/ 10);
}

class _ChapterCard extends StatelessWidget {
  const _ChapterCard({
    required this.width,
    required this.chapter,
    required this.index,
    required this.startDuration,
    required this.endDuration,
    required this.serverUrl,
    required this.itemId,
    required this.onTap,
  });

  final double width;
  final ChapterInfo chapter;
  final int index;
  final Duration startDuration;
  final Duration endDuration;
  final String serverUrl;
  final String itemId;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasImage = chapter.imageTag != null && chapter.imageTag!.isNotEmpty;
    final imageUrl = hasImage
        ? '$serverUrl/Items/$itemId/Images/Chapter'
              '?imageIndex=$index'
              '&maxHeight=200&quality=80'
              '&tag=${chapter.imageTag}'
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const _ChapterThumbPlaceholder(),
                      )
                    : const _ChapterThumbPlaceholder(),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      chapter.name ?? 'Chapter ${index + 1}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: .5),
                    Text(
                      _fmt(startDuration),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }
}

class _ChapterThumbPlaceholder extends StatelessWidget {
  const _ChapterThumbPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: const Center(
        child: Icon(
          Icons.movie_filter_rounded,
          color: Colors.white24,
          size: 28,
        ),
      ),
    );
  }
}
