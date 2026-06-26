import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class GenreChips extends StatelessWidget {
  const GenreChips({super.key, required this.genres});

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
