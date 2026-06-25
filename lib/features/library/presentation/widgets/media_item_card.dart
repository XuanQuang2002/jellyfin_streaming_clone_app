import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';
import 'jellyfin_image.dart';

class MediaItemCard extends StatelessWidget {
  const MediaItemCard({
    super.key,
    required this.item,
    required this.serverUrl,
    this.onTap,
  });

  final MediaItem item;
  final String serverUrl;
  final VoidCallback? onTap;

  static const _posterAspectRatio = 2 / 3;

  @override
  Widget build(BuildContext context) {
    final hasPoster =
        item.imageTags != null && item.imageTags!.containsKey('Primary');

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Poster ────────────────────────────────────────────────────
          Expanded(
            child: AspectRatio(
              aspectRatio: _posterAspectRatio,
              child: hasPoster
                  ? JellyfinImage(
                      serverUrl: serverUrl,
                      itemId: item.id,
                      tag: item.imageTags!['Primary'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : _FallbackPoster(type: item.type),
            ),
          ),
          const SizedBox(height: 6),
          // ── Title ─────────────────────────────────────────────────────
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimaryDark,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.3,
              decoration: TextDecoration.none,
            ),
          ),
          if (item.productionYear != null) ...[
            const SizedBox(height: 2),
            Text(
              '${item.productionYear}',
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 11,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FallbackPoster extends StatelessWidget {
  const _FallbackPoster({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final icon = switch (type.toLowerCase()) {
      'movie' => Icons.movie_rounded,
      'series' => Icons.tv_rounded,
      'episode' => Icons.play_circle_rounded,
      'musicalbum' || 'audio' => Icons.album_rounded,
      _ => Icons.folder_rounded,
    };

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: AppColors.cardDark,
        child: Center(
          child: Icon(icon, color: AppColors.textSecondaryDark, size: 40),
        ),
      ),
    );
  }
}
