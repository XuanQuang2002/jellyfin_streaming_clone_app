import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/theme/app_theme.dart';

class ExpandableOverview extends HookWidget {
  const ExpandableOverview({super.key, required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    final expanded = useState(false);

    return GestureDetector(
      onTap: () => expanded.value = !expanded.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            firstChild: Text(
              overview,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            secondChild: Text(
              overview,
              style: const TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            crossFadeState: expanded.value
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
          const SizedBox(height: 4),
          Text(
            expanded.value ? 'Show less' : 'Read more',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
