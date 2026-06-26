import 'package:flutter/material.dart';
import 'package:jellyfin_streaming_clone_app/features/library/data/models/library_models.dart';
import 'package:media_kit/media_kit.dart';

import 'player_bottom_bar.dart';
import 'player_center_controls.dart';
import 'player_gradients.dart';
import 'player_top_bar.dart';

class PlayerControlsOverlay extends StatelessWidget {
  const PlayerControlsOverlay({
    super.key,
    required this.player,
    required this.item,
    required this.playing,
    required this.hasPrev,
    required this.hasNext,
    required this.onBack,
    required this.onSettings,
    required this.onInfo,
    required this.onChapters,
    required this.onCast,
    this.onEpisodes,
    this.onPrev,
    this.onNext,
  });

  final Player player;
  final MediaItem? item;
  final bool playing;
  final bool hasPrev;
  final bool hasNext;
  final VoidCallback onBack;
  final VoidCallback onSettings;
  final VoidCallback onInfo;
  final VoidCallback onChapters;
  final VoidCallback onCast;
  final VoidCallback? onEpisodes;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const PlayerGradients(),

        // Top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: PlayerTopBar(
              item: item,
              onBack: onBack,
              onSettings: onSettings,
              onCast: onCast,
            ),
          ),
        ),

        // Center controls
        Center(
          child: PlayerCenterControls(
            player: player,
            playing: playing,
            hasPrev: hasPrev,
            hasNext: hasNext,
            onPrev: onPrev,
            onNext: onNext,
          ),
        ),

        // Bottom bar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            top: false,
            child: PlayerBottomBar(
              player: player,
              onInfo: onInfo,
              onChapters: onChapters,
              onEpisodes: onEpisodes,
            ),
          ),
        ),
      ],
    );
  }
}
