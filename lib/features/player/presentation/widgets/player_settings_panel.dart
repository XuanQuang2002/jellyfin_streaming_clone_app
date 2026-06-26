import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:media_kit/media_kit.dart';

import '../../../../../core/theme/app_theme.dart';

class PlayerSettingsPanel extends HookWidget {
  const PlayerSettingsPanel({
    super.key,
    required this.player,
    required this.onClose,
  });

  final Player player;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final tracks = useStream(
      player.stream.tracks,
      initialData: player.state.tracks,
    );
    final selTrack = useStream(
      player.stream.track,
      initialData: player.state.track,
    );
    final rate = useStream(player.stream.rate, initialData: player.state.rate);

    final t = tracks.data ?? player.state.tracks;
    final ct = selTrack.data ?? player.state.track;
    final currentRate = rate.data ?? 1.0;

    const speeds = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

    return Container(
      width: 272,
      decoration: const BoxDecoration(
        color: Color(0xF0111111),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
      ),
      child: SafeArea(
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 12, 10),
              child: Row(
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onClose,
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12, height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                children: [
                  _SettingGroup(
                    title: 'PLAYBACK SPEED',
                    children: speeds
                        .map(
                          (s) => _SettingItem(
                            label: s == 1.0 ? 'Normal' : '$s×',
                            selected: (currentRate - s).abs() < 0.01,
                            onTap: () => player.setRate(s),
                          ),
                        )
                        .toList(),
                  ),
                  if (t.audio.length > 1) ...[
                    const SizedBox(height: 16),
                    _SettingGroup(
                      title: 'AUDIO',
                      children: t.audio
                          .map(
                            (a) => _SettingItem(
                              label: _trackLabel(a.title, a.language, a.id),
                              selected: ct.audio.id == a.id,
                              onTap: () => player.setAudioTrack(a),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 16),
                  _SettingGroup(
                    title: 'SUBTITLES',
                    children: [
                      _SettingItem(
                        label: 'Off',
                        selected: ct.subtitle == SubtitleTrack.no(),
                        onTap: () =>
                            player.setSubtitleTrack(SubtitleTrack.no()),
                      ),
                      ...t.subtitle.map(
                        (s) => _SettingItem(
                          label: _trackLabel(s.title, s.language, s.id),
                          selected: ct.subtitle.id == s.id,
                          onTap: () => player.setSubtitleTrack(s),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _trackLabel(String? title, String? language, String? id) {
    if (title != null && title.isNotEmpty) return title;
    if (language != null && language.isNotEmpty) return language.toUpperCase();
    return 'Track ${id ?? '?'}';
  }
}

class _SettingGroup extends StatelessWidget {
  const _SettingGroup({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        ...children,
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  const _SettingItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: selected ? AppColors.primary : Colors.white30,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white60,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
