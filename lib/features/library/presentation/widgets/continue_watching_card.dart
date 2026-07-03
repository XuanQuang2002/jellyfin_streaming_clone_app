import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';
import 'jellyfin_image.dart';

/// A landscape card for the "Continue Watching" row, showing a thumbnail,
/// a resume progress bar, and a title/subtitle.
class ContinueWatchingCard extends StatelessWidget {
  const ContinueWatchingCard({
    super.key,
    required this.item,
    required this.serverUrl,
    this.onTap,
  });

  final MediaItem item;
  final String serverUrl;
  final VoidCallback? onTap;

  static const double width = 200;

  double get _progress {
    final total = item.runTimeTicks;
    final position = item.userData?.playbackPositionTicks;
    if (total == null || total <= 0 || position == null) return 0;
    return (position / total).clamp(0.0, 1.0);
  }

  bool get _isEpisode => item.type == 'Episode';

  String get _title => _isEpisode ? (item.seriesName ?? item.name) : item.name;

  String? get _subtitle {
    if (!_isEpisode) {
      return item.productionYear?.toString();
    }
    final s = item.parentIndexNumber;
    final e = item.indexNumber;
    final label = [
      if (s != null) 'S$s',
      if (e != null) 'E$e',
    ].join(' · ');
    return [label, item.name].where((t) => t.isNotEmpty).join(' · ');
  }

  ({String imageType, String? tag}) get _image {
    // Episodes use their landscape still (Primary); movies prefer a backdrop.
    if (_isEpisode) {
      return (imageType: 'Primary', tag: item.imageTags?['Primary']);
    }
    final backdrop = item.backdropImageTags;
    if (backdrop != null && backdrop.isNotEmpty) {
      return (imageType: 'Backdrop', tag: backdrop.first);
    }
    return (imageType: 'Primary', tag: item.imageTags?['Primary']);
  }

  @override
  Widget build(BuildContext context) {
    final image = _image;
    final subtitle = _subtitle;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail + progress + play affordance ──────────────────
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  JellyfinImage(
                    serverUrl: serverUrl,
                    itemId: item.id,
                    imageType: image.imageType,
                    tag: image.tag,
                    fit: BoxFit.cover,
                    fallbackIcon: _isEpisode
                        ? Icons.play_circle_rounded
                        : Icons.movie_rounded,
                  ),
                  // Play icon overlay
                  const Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white70,
                      size: 40,
                    ),
                  ),
                  // Progress bar pinned to bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: LinearProgressIndicator(
                        value: _progress,
                        minHeight: 4,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            // ── Title ─────────────────────────────────────────────────────
            Text(
              _title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimaryDark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
            if (subtitle != null && subtitle.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textSecondaryDark,
                  fontSize: 11,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
