import 'package:flutter/material.dart';
import 'package:jellyfin_streaming_clone_app/features/library/data/models/library_models.dart';

import '../../../../../core/theme/app_theme.dart';
import 'player_panel_sheet.dart';

class PlayerEpisodesPanel extends StatelessWidget {
  const PlayerEpisodesPanel({
    super.key,
    required this.episodes,
    required this.currentEpisodeId,
    required this.serverUrl,
    required this.onEpisodeSelected,
    required this.onClose,
  });

  final List<EpisodeItem> episodes;
  final String currentEpisodeId;
  final String serverUrl;
  final ValueChanged<String> onEpisodeSelected;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return PlayerPanelSheet(
      title: 'Episodes',
      onClose: onClose,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Card width derived from panel height so cards fill the available height
          final cardWidth = constraints.maxHeight;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            itemCount: episodes.length,
            itemBuilder: (context, i) {
              final ep = episodes[i];
              final isCurrent = ep.id == currentEpisodeId;
              final hasThumb = ep.imageTags?.containsKey('Primary') == true;

              return GestureDetector(
                onTap: () => onEpisodeSelected(ep.id),
                child: Container(
                  width: cardWidth,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? AppColors.primary.withValues(alpha: 0.18)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                    border: isCurrent
                        ? Border.all(
                            color: AppColors.primary.withValues(alpha: 0.5),
                          )
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(5),
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: hasThumb
                              ? Image.network(
                                  '$serverUrl/Items/${ep.id}/Images/Primary'
                                  '?maxHeight=200&quality=80'
                                  '&tag=${ep.imageTags!['Primary']}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      const _EpThumbPlaceholder(),
                                )
                              : const _EpThumbPlaceholder(),
                        ),
                      ),
                      SizedBox(height: 6),
                      // Info
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (ep.indexNumber != null)
                                Text(
                                  'E${ep.indexNumber}',
                                  style: TextStyle(
                                    color: isCurrent
                                        ? AppColors.primary
                                        : Colors.white38,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  ep.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isCurrent
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: 12,
                                    fontWeight: isCurrent
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    height: 1.3,
                                  ),
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
            },
          );
        },
      ),
    );
  }
}

class _EpThumbPlaceholder extends StatelessWidget {
  const _EpThumbPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: const Center(
        child: Icon(
          Icons.play_circle_outline_rounded,
          color: Colors.white24,
          size: 28,
        ),
      ),
    );
  }
}
