import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';

import '../../../../../core/theme/app_theme.dart';

class PlayerBottomBar extends HookWidget {
  const PlayerBottomBar({
    super.key,
    required this.player,
    required this.onInfo,
    required this.onChapters,
    this.onEpisodes,
  });

  final Player player;
  final VoidCallback onInfo;
  final VoidCallback onChapters;
  final VoidCallback? onEpisodes;

  @override
  Widget build(BuildContext context) {
    final position = useStream(
      player.stream.position,
      initialData: Duration.zero,
    );
    final duration = useStream(
      player.stream.duration,
      initialData: Duration.zero,
    );
    final isDragging = useState(false);
    final dragPos = useState(0.0);

    final dur = duration.data ?? Duration.zero;
    final pos = isDragging.value
        ? Duration(milliseconds: (dragPos.value * dur.inMilliseconds).round())
        : (position.data ?? Duration.zero);
    final progress = dur.inMilliseconds > 0
        ? (pos.inMilliseconds / dur.inMilliseconds).clamp(0.0, 1.0)
        : 0.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              PlayerPanelBtn(
                icon: Icons.info_outline_rounded,
                label: 'Info',
                onTap: onInfo,
              ),
              const SizedBox(width: 2),
              PlayerPanelBtn(
                icon: Icons.format_list_bulleted_rounded,
                label: 'Chapters',
                onTap: onChapters,
              ),
              if (onEpisodes != null) ...[
                const SizedBox(width: 2),
                PlayerPanelBtn(
                  icon: Icons.video_library_outlined,
                  label: 'Episodes',
                  onTap: onEpisodes!,
                ),
              ],
              const Spacer(),
              Text(
                '${_fmt(pos)}  /  ${_fmt(dur)}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: Colors.white24,
              thumbColor: Colors.white,
              overlayColor: AppColors.primary.withValues(alpha: 0.22),
            ),
            child: Slider(
              value: progress,
              onChangeStart: (v) {
                isDragging.value = true;
                dragPos.value = v;
              },
              onChanged: (v) => dragPos.value = v,
              onChangeEnd: (v) {
                isDragging.value = false;
                player.seek(
                  Duration(milliseconds: (v * dur.inMilliseconds).round()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }
}

class PlayerPanelBtn extends StatelessWidget {
  const PlayerPanelBtn({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white70, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
