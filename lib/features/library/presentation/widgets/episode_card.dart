import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';
import 'jellyfin_image.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
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
                            const EpisodeThumbnailPlaceholder(),
                      )
                    : const EpisodeThumbnailPlaceholder(),
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

  static String _formatRuntime(int ticks) {
    final minutes = (ticks / 600000000).round();
    if (minutes < 60) return '${minutes}m';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }
}

class EpisodeThumbnailPlaceholder extends StatelessWidget {
  const EpisodeThumbnailPlaceholder({super.key});

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
