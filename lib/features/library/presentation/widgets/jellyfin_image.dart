import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Builds the Jellyfin image URL for a given [itemId] and optional [tag].
String jellyfinImageUrl(
  String serverUrl,
  String itemId, {
  String imageType = 'Primary',
  String? tag,
  int maxHeight = 320,
}) {
  final tagParam = tag != null ? '&tag=$tag' : '';
  return '$serverUrl/Items/$itemId/Images/$imageType'
      '?maxHeight=$maxHeight&quality=90$tagParam';
}

/// Renders a Jellyfin poster image with a fallback placeholder.
class JellyfinImage extends StatelessWidget {
  const JellyfinImage({
    super.key,
    required this.serverUrl,
    required this.itemId,
    this.tag,
    this.imageType = 'Primary',
    this.width,
    this.height,
    this.borderRadius = 8,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.movie_rounded,
  });

  final String serverUrl;
  final String itemId;
  final String? tag;
  final String imageType;
  final double? width;
  final double? height;
  final double borderRadius;
  final BoxFit fit;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final url = jellyfinImageUrl(
      serverUrl,
      itemId,
      imageType: imageType,
      tag: tag,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) =>
            _Placeholder(width: width, height: height, icon: fallbackIcon),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return _Placeholder(
            width: width,
            height: height,
            icon: fallbackIcon,
            showProgress: true,
          );
        },
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    this.width,
    this.height,
    required this.icon,
    this.showProgress = false,
  });

  final double? width;
  final double? height;
  final IconData icon;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.cardDark,
      child: Center(
        child: showProgress
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : Icon(icon, color: AppColors.textSecondaryDark, size: 32),
      ),
    );
  }
}
