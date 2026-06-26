import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';

class SeasonSelector extends StatelessWidget {
  const SeasonSelector({
    super.key,
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
