import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';

class MediaMetaRow extends StatelessWidget {
  const MediaMetaRow({super.key, required this.item});

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
