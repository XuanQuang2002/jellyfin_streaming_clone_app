import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

class PlayerCenterControls extends StatelessWidget {
  const PlayerCenterControls({
    super.key,
    required this.player,
    required this.playing,
    required this.hasPrev,
    required this.hasNext,
    this.onPrev,
    this.onNext,
  });

  final Player player;
  final bool playing;
  final bool hasPrev;
  final bool hasNext;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  void _skip(int ms) {
    final cur = player.state.position.inMilliseconds;
    final dur = player.state.duration.inMilliseconds;
    player.seek(Duration(milliseconds: (cur + ms).clamp(0, dur)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlayerCtrlBtn(
          icon: Icons.skip_previous_rounded,
          size: 32,
          enabled: hasPrev,
          onTap: onPrev,
        ),
        const SizedBox(width: 16),
        PlayerCtrlBtn(
          icon: Icons.replay_10_rounded,
          size: 34,
          onTap: () => _skip(-10000),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: player.playOrPause,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white30, width: 1.5),
            ),
            child: Icon(
              playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const SizedBox(width: 20),
        PlayerCtrlBtn(
          icon: Icons.forward_10_rounded,
          size: 34,
          onTap: () => _skip(10000),
        ),
        const SizedBox(width: 16),
        PlayerCtrlBtn(
          icon: Icons.skip_next_rounded,
          size: 32,
          enabled: hasNext,
          onTap: onNext,
        ),
      ],
    );
  }
}

class PlayerCtrlBtn extends StatelessWidget {
  const PlayerCtrlBtn({
    super.key,
    required this.icon,
    required this.size,
    this.enabled = true,
    this.onTap,
  });

  final IconData icon;
  final double size;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Icon(
        icon,
        size: size,
        color: enabled ? Colors.white : Colors.white30,
        shadows: const [Shadow(color: Colors.black54, blurRadius: 8)],
      ),
    );
  }
}
