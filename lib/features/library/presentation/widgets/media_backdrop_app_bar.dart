import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../data/models/library_models.dart';
import 'jellyfin_image.dart';

class MediaBackdropAppBar extends StatelessWidget {
  const MediaBackdropAppBar({
    super.key,
    required this.item,
    required this.serverUrl,
  });

  final MediaItem item;
  final String serverUrl;

  @override
  Widget build(BuildContext context) {
    final hasBackdrop =
        item.backdropImageTags != null && item.backdropImageTags!.isNotEmpty;
    final hasPoster =
        item.imageTags != null && item.imageTags!.containsKey('Primary');

    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (hasBackdrop)
              Image.network(
                jellyfinImageUrl(
                  serverUrl,
                  item.id,
                  imageType: 'Backdrop',
                  tag: item.backdropImageTags!.first,
                  maxHeight: 480,
                ),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const MediaBackdropPlaceholder(),
              )
            else if (hasPoster)
              Image.network(
                jellyfinImageUrl(
                  serverUrl,
                  item.id,
                  imageType: 'Primary',
                  tag: item.imageTags!['Primary'],
                  maxHeight: 480,
                ),
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const MediaBackdropPlaceholder(),
              )
            else
              const MediaBackdropPlaceholder(),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4, 1.0],
                  colors: [Colors.transparent, AppColors.backgroundDark],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MediaBackdropPlaceholder extends StatelessWidget {
  const MediaBackdropPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceDark,
      child: const Center(
        child: Icon(
          Icons.movie_rounded,
          color: AppColors.textSecondaryDark,
          size: 48,
        ),
      ),
    );
  }
}
