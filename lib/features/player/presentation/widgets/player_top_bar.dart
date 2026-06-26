import 'package:flutter/material.dart';
import 'package:jellyfin_streaming_clone_app/features/library/data/models/library_models.dart';

import '../../../../../core/theme/app_theme.dart';

class PlayerTopBar extends StatelessWidget {
  const PlayerTopBar({
    super.key,
    required this.item,
    required this.onBack,
    required this.onSettings,
    required this.onCast,
  });

  final MediaItem? item;
  final VoidCallback onBack;
  final VoidCallback onSettings;
  final VoidCallback onCast;

  @override
  Widget build(BuildContext context) {
    final isEpisode = item?.type == 'Episode';
    final title = isEpisode ? (item?.seriesName ?? '') : (item?.name ?? '');
    final subtitle = isEpisode ? item?.name : null;
    final badge =
        (isEpisode &&
            item?.parentIndexNumber != null &&
            item?.indexNumber != null)
        ? 'S${item!.parentIndexNumber} · E${item!.indexNumber}'
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: onBack,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badge != null)
                  Text(
                    badge,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                    ),
                  ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.white,
              size: 22,
            ),
            onPressed: onSettings,
          ),
          IconButton(
            icon: const Icon(Icons.cast_rounded, color: Colors.white, size: 22),
            onPressed: onCast,
          ),
        ],
      ),
    );
  }
}
