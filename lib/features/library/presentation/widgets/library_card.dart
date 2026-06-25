import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';
import 'jellyfin_image.dart';

class LibraryCard extends StatelessWidget {
  const LibraryCard({
    super.key,
    required this.library,
    required this.serverUrl,
    this.onTap,
  });

  final UserView library;
  final String serverUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final hasPrimary =
        library.imageTags != null &&
        library.imageTags!.containsKey('Primary');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background image ─────────────────────────────────────────
            if (hasPrimary)
              JellyfinImage(
                serverUrl: serverUrl,
                itemId: library.id,
                tag: library.imageTags!['Primary'],
                fit: BoxFit.cover,
              )
            else
              Center(
                child: Icon(
                  _iconFor(library.collectionType),
                  size: 48,
                  color: AppColors.textSecondaryDark,
                ),
              ),
            // ── Gradient overlay + title ─────────────────────────────────
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withAlpha(204),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Text(
                  library.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black54),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String? collectionType) {
    return switch (collectionType?.toLowerCase()) {
      'movies' => Icons.movie_rounded,
      'tvshows' => Icons.tv_rounded,
      'music' => Icons.music_note_rounded,
      'books' => Icons.book_rounded,
      'photos' => Icons.photo_library_rounded,
      _ => Icons.folder_rounded,
    };
  }
}
