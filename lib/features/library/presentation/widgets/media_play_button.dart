import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';

class MediaPlayButton extends StatelessWidget {
  const MediaPlayButton({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => context.push('/home/player/$itemId'),
        icon: const Icon(Icons.play_arrow_rounded, size: 22),
        label: const Text(
          'Play',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
