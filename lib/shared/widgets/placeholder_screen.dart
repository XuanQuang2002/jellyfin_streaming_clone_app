import 'package:flutter/material.dart';
import '../../core/theme/platform_widget.dart';
import '../../core/theme/app_theme.dart';

/// Temporary screen used as a placeholder until each feature screen is built.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: title,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction_rounded,
              size: 48,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            const Text(
              'Coming soon',
              style: TextStyle(
                color: AppColors.textSecondaryDark,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
