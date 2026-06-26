import 'package:flutter/material.dart';
import 'package:jellyfin_streaming_clone_app/features/library/data/models/library_models.dart';

import '../../../../../core/theme/app_theme.dart';
import 'player_panel_sheet.dart';

class PlayerInfoPanel extends StatelessWidget {
  const PlayerInfoPanel({super.key, required this.item, required this.onClose});

  final MediaItem? item;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return PlayerPanelSheet(
      onClose: onClose,
      child: item == null
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item!.type == 'Episode'
                        ? '${item!.seriesName ?? ''} — ${item!.name}'
                        : item!.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (item!.communityRating != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.warning,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              item!.communityRating!.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      if (item!.productionYear != null)
                        Text(
                          '${item!.productionYear}',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      if (item!.officialRating != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white30),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            item!.officialRating!,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (item!.overview != null && item!.overview!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      item!.overview!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                  if (item!.genres != null && item!.genres!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: item!.genres!
                          .map(
                            (g) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                g,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
