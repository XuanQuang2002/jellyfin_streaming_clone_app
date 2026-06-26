import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../../../library/data/models/library_models.dart';
import '../../../library/domain/providers/library_provider.dart';

// ─── Active Panel Enum ────────────────────────────────────────────────────────

enum _Panel { none, settings, info, chapters, episodes }

// ─── Player Screen ────────────────────────────────────────────────────────────

class PlayerScreen extends HookConsumerWidget {
  const PlayerScreen({super.key, required this.itemId});
  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ── Landscape lock + immersive mode ─────────────────────────────────────
    useEffect(() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      return () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      };
    }, const []);

    // ── Player + VideoController ─────────────────────────────────────────────
    final player = useMemoized(
      () => Player(
        configuration: const PlayerConfiguration(
          // Suppress verbose mpv logs in release; set to warn for debugging.
          logLevel: MPVLogLevel.warn,
          // 32 MB demux/decode buffer for smoother network streams.
          bufferSize: 32 * 1024 * 1024,
        ),
      ),
    );
    final controller = useMemoized(() => VideoController(player));
    useEffect(() => player.dispose, []);

    // ── Player error state ───────────────────────────────────────────────────
    final playerError = useState<String?>(null);

    // ── Current item ID (changes on episode navigation) ──────────────────────
    final currentItemId = useState(itemId);

    // ── Remote data ──────────────────────────────────────────────────────────
    final auth = ref.watch(authenticatedStateProvider);
    final itemAsync = ref.watch(mediaItemDetailProvider(currentItemId.value));
    final item = itemAsync.value;

    // Episodes context (only when item is an episode)
    final episodesAsync =
        (item?.type == 'Episode' &&
            item?.seriesId != null &&
            item?.seasonId != null)
        ? ref.watch(
            episodesProvider((
              seriesId: item!.seriesId!,
              seasonId: item.seasonId!,
            )),
          )
        : const AsyncData<List<EpisodeItem>>([]);
    final episodes = episodesAsync.value ?? const <EpisodeItem>[];

    final episodeIndex = useMemoized(
      () => episodes.indexWhere((e) => e.id == currentItemId.value),
      [episodes, currentItemId.value],
    );
    final hasPrev = episodeIndex > 0;
    final hasNext = episodeIndex >= 0 && episodeIndex < episodes.length - 1;
    final nextEpisodeId = hasNext ? episodes[episodeIndex + 1].id : null;

    // ── Subscribe to player errors ─────────────────────────────────────────
    useEffect(() {
      final sub = player.stream.error.listen((err) {
        playerError.value = err;
      });
      return sub.cancel;
    }, const []);

    // ── Open media when item is ready ────────────────────────────────────────
    useEffect(() {
      if (item == null || auth == null) return null;
      playerError.value = null;
      final url = _streamUrl(auth.serverUrl, item.id, auth.accessToken);
      // Pass the token as an HTTP header in addition to the query param so
      // libmpv's HTTP stack on Android always sends credentials regardless of
      // how it handles query strings.
      player.open(Media(url, httpHeaders: {'X-Emby-Token': auth.accessToken}));
      return null;
    }, [item?.id, auth?.serverUrl]);

    // ── Auto-advance to next episode on completion ───────────────────────────
    useEffect(() {
      final sub = player.stream.completed.listen((done) {
        if (!done || nextEpisodeId == null) return;
        currentItemId.value = nextEpisodeId;
      });
      return sub.cancel;
    }, [nextEpisodeId]);

    // ── Controls visibility ──────────────────────────────────────────────────
    final controlsVisible = useState(true);
    final hideTimerRef = useRef<Timer?>(null);

    void scheduleHide() {
      hideTimerRef.value?.cancel();
      hideTimerRef.value = Timer(
        const Duration(seconds: 4),
        () => controlsVisible.value = false,
      );
    }

    void showControls() {
      controlsVisible.value = true;
      scheduleHide();
    }

    // Cancel timer when widget disposes
    useEffect(
      () =>
          () => hideTimerRef.value?.cancel(),
      const [],
    );

    // ── Active panel ─────────────────────────────────────────────────────────
    final activePanel = useState(_Panel.none);

    void openPanel(_Panel panel) {
      hideTimerRef.value?.cancel();
      activePanel.value = panel;
      controlsVisible.value = true;
    }

    void closePanel() {
      activePanel.value = _Panel.none;
      scheduleHide();
    }

    // ── Episode navigation ───────────────────────────────────────────────────
    void goToEpisode(String id) {
      currentItemId.value = id;
      activePanel.value = _Panel.none;
      scheduleHide();
    }

    // ── Stream state ─────────────────────────────────────────────────────────
    final playing = useStream(player.stream.playing, initialData: false);
    final buffering = useStream(player.stream.buffering, initialData: true);

    // Start hide timer once playback begins
    useEffect(() {
      if (playing.data == true) scheduleHide();
      return null;
    }, [playing.data]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final panelH = constraints.maxHeight * 0.46;

          return Stack(
            fit: StackFit.expand,
            children: [
              // ── Video ──────────────────────────────────────────────────────
              Video(
                controller: controller,
                fit: BoxFit.contain,
                controls: NoVideoControls,
              ),

              // ── Buffering / loading spinner ────────────────────────────────
              if (buffering.data == true || itemAsync.isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white70,
                    strokeWidth: 2.5,
                  ),
                ),

              // ── Player error overlay ───────────────────────────────────────
              if (playerError.value != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.redAccent,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Playback error',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          playerError.value!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ── Background tap handler (must be BELOW controls so buttons
              //    above it win the gesture arena) ────────────────────────────
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (activePanel.value != _Panel.none) {
                    closePanel();
                  } else {
                    showControls();
                  }
                },
              ),

              // ── Controls overlay ───────────────────────────────────────────
              IgnorePointer(
                ignoring: !controlsVisible.value,
                child: AnimatedOpacity(
                  opacity: controlsVisible.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: _ControlsOverlay(
                    player: player,
                    item: item,
                    playing: playing.data ?? false,
                    hasPrev: hasPrev,
                    hasNext: hasNext,
                    onBack: () {
                      player.stop();
                      Navigator.of(context).pop();
                    },
                    onSettings: () => openPanel(_Panel.settings),
                    onInfo: () => openPanel(_Panel.info),
                    onChapters: () => openPanel(_Panel.chapters),
                    onEpisodes: item?.type == 'Episode'
                        ? () => openPanel(_Panel.episodes)
                        : null,
                    onPrev: hasPrev
                        ? () => goToEpisode(episodes[episodeIndex - 1].id)
                        : null,
                    onNext: hasNext
                        ? () => goToEpisode(episodes[episodeIndex + 1].id)
                        : null,
                    onCast: () async {
                      debugPrint('Cast button pressed (not implemented)');
                    },
                  ),
                ),
              ),

              // ── Panel dismiss overlay (tapping outside panel closes it) ────
              if (activePanel.value != _Panel.none)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: closePanel,
                  child: const SizedBox.expand(),
                ),

              // ── Settings panel (slides in from right) ─────────────────────
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: 0,
                bottom: 0,
                right: activePanel.value == _Panel.settings ? 0 : -300,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: _SettingsPanel(player: player, onClose: closePanel),
                ),
              ),

              // ── Info panel (slides up from bottom) ─────────────────────────
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: 0,
                right: 0,
                bottom: activePanel.value == _Panel.info ? 0 : -(panelH + 20),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: SizedBox(
                    height: panelH,
                    child: _InfoPanel(item: item, onClose: closePanel),
                  ),
                ),
              ),

              // ── Episodes panel (slides up from bottom) ─────────────────────
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: 0,
                right: 0,
                bottom: activePanel.value == _Panel.episodes
                    ? 0
                    : -(panelH + 20),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: SizedBox(
                    height: panelH,
                    child: _EpisodesPanel(
                      episodes: episodes,
                      currentEpisodeId: currentItemId.value,
                      serverUrl: auth?.serverUrl ?? '',
                      onEpisodeSelected: goToEpisode,
                      onClose: closePanel,
                    ),
                  ),
                ),
              ),

              // ── Chapters panel (slides up from bottom) ─────────────────────
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: 0,
                right: 0,
                bottom: activePanel.value == _Panel.chapters
                    ? 0
                    : -(panelH + 20),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: SizedBox(
                    height: panelH,
                    child: _ChaptersPanel(player: player, onClose: closePanel),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  static String _streamUrl(String serverUrl, String itemId, String token) {
    final base = serverUrl.replaceAll(RegExp(r'/+$'), '');
    return '$base/Videos/$itemId/stream'
        '?api_key=${Uri.encodeComponent(token)}'
        '&static=true'
        '&mediaSourceId=$itemId'
        '&Tag=$itemId';
  }
}

// ─── Controls Overlay ─────────────────────────────────────────────────────────

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({
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
        const _Gradients(),

        // Top bar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: _TopBar(
              item: item,
              onBack: onBack,
              onSettings: onSettings,
              onCast: onCast,
            ),
          ),
        ),

        // Center controls
        Center(
          child: _CenterControls(
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
            child: _BottomBar(
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

// ─── Gradients ────────────────────────────────────────────────────────────────

class _Gradients extends StatelessWidget {
  const _Gradients();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 130,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.72),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 160,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.82),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Top Bar ──────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.item,
    required this.onBack,
    required this.onSettings,
    required this.onCast,
  });

  final MediaItem? item;
  final VoidCallback onBack;
  final VoidCallback onSettings;
  final VoidCallback onCast;

  @override
  Widget build(BuildContext context) {
    final isEpisode = item?.type == 'Episode';
    final title = isEpisode ? (item?.seriesName ?? '') : (item?.name ?? '');
    final subtitle = isEpisode ? item?.name : null;
    final badge =
        (isEpisode &&
            item?.parentIndexNumber != null &&
            item?.indexNumber != null)
        ? 'S${item!.parentIndexNumber} · E${item!.indexNumber}'
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: onBack,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badge != null)
                  Text(
                    badge,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                    ),
                  ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.white,
              size: 22,
            ),
            onPressed: onSettings,
          ),
          IconButton(
            icon: const Icon(Icons.cast_rounded, color: Colors.white, size: 22),
            onPressed: onCast,
          ),
        ],
      ),
    );
  }
}

// ─── Center Controls ──────────────────────────────────────────────────────────

class _CenterControls extends StatelessWidget {
  const _CenterControls({
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
        _CtrlBtn(
          icon: Icons.skip_previous_rounded,
          size: 32,
          enabled: hasPrev,
          onTap: onPrev,
        ),
        const SizedBox(width: 16),
        _CtrlBtn(
          icon: Icons.replay_10_rounded,
          size: 34,
          onTap: () => _skip(-10000),
        ),
        const SizedBox(width: 20),
        // Play / Pause
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
        _CtrlBtn(
          icon: Icons.forward_10_rounded,
          size: 34,
          onTap: () => _skip(10000),
        ),
        const SizedBox(width: 16),
        _CtrlBtn(
          icon: Icons.skip_next_rounded,
          size: 32,
          enabled: hasNext,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _CtrlBtn extends StatelessWidget {
  const _CtrlBtn({
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

// ─── Bottom Bar ───────────────────────────────────────────────────────────────

class _BottomBar extends HookWidget {
  const _BottomBar({
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
              // Bottom-left: panel launcher buttons
              _PanelBtn(
                icon: Icons.info_outline_rounded,
                label: 'Info',
                onTap: onInfo,
              ),
              const SizedBox(width: 2),
              _PanelBtn(
                icon: Icons.format_list_bulleted_rounded,
                label: 'Chapters',
                onTap: onChapters,
              ),
              if (onEpisodes != null) ...[
                const SizedBox(width: 2),
                _PanelBtn(
                  icon: Icons.video_library_outlined,
                  label: 'Episodes',
                  onTap: onEpisodes!,
                ),
              ],
              const Spacer(),
              // Time
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
          // Progress slider
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

class _PanelBtn extends StatelessWidget {
  const _PanelBtn({
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

// ─── Settings Panel ───────────────────────────────────────────────────────────

class _SettingsPanel extends HookWidget {
  const _SettingsPanel({required this.player, required this.onClose});

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
            // Header
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
                  // Playback speed
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

                  // Audio tracks
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

                  // Subtitle tracks
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

// ─── Info Panel ───────────────────────────────────────────────────────────────

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({required this.item, required this.onClose});
  final MediaItem? item;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return _PanelSheet(
      onClose: onClose,
      child: item == null
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item!.type == 'Episode'
                        ? '${item!.seriesName ?? ''} — ${item!.name}'
                        : item!.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (item!.communityRating != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.warning,
                              size: 14,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              item!.communityRating!.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      if (item!.productionYear != null)
                        Text(
                          '${item!.productionYear}',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      if (item!.officialRating != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white30),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            item!.officialRating!,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (item!.overview != null && item!.overview!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      item!.overview!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                  if (item!.genres != null && item!.genres!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: item!.genres!
                          .map(
                            (g) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                g,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}

// ─── Episodes Panel ───────────────────────────────────────────────────────────

class _EpisodesPanel extends StatelessWidget {
  const _EpisodesPanel({
    required this.episodes,
    required this.currentEpisodeId,
    required this.serverUrl,
    required this.onEpisodeSelected,
    required this.onClose,
  });

  final List<EpisodeItem> episodes;
  final String currentEpisodeId;
  final String serverUrl;
  final ValueChanged<String> onEpisodeSelected;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return _PanelSheet(
      title: 'Episodes',
      onClose: onClose,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        itemCount: episodes.length,
        itemBuilder: (context, i) {
          final ep = episodes[i];
          final isCurrent = ep.id == currentEpisodeId;
          final hasThumb = ep.imageTags?.containsKey('Primary') == true;

          return GestureDetector(
            onTap: () => onEpisodeSelected(ep.id),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isCurrent
                    ? AppColors.primary.withValues(alpha: 0.18)
                    : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
                border: isCurrent
                    ? Border.all(
                        color: AppColors.primary.withValues(alpha: 0.5),
                      )
                    : null,
              ),
              child: Column(
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: SizedBox(
                      width: 100,
                      height: 58,
                      child: hasThumb
                          ? Image.network(
                              '$serverUrl/Items/${ep.id}/Images/Primary'
                              '?maxHeight=116&quality=80&tag=${ep.imageTags!['Primary']}',
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const _EpThumb(),
                            )
                          : const _EpThumb(),
                    ),
                  ),
                  // Info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (ep.indexNumber != null)
                            Text(
                              'E${ep.indexNumber}',
                              style: TextStyle(
                                color: isCurrent
                                    ? AppColors.primary
                                    : Colors.white38,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          Text(
                            ep.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isCurrent ? Colors.white : Colors.white70,
                              fontSize: 12,
                              fontWeight: isCurrent
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isCurrent)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EpThumb extends StatelessWidget {
  const _EpThumb();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white10,
      child: const Center(
        child: Icon(
          Icons.play_circle_outline_rounded,
          color: Colors.white24,
          size: 22,
        ),
      ),
    );
  }
}

// ─── Chapters Panel ───────────────────────────────────────────────────────────

class _ChaptersPanel extends HookWidget {
  const _ChaptersPanel({required this.player, required this.onClose});
  final Player player;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return _PanelSheet(
      title: 'Chapters',
      onClose: onClose,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.format_list_bulleted_rounded,
              color: Colors.white24,
              size: 40,
            ),
            SizedBox(height: 10),
            Text(
              'No chapters available',
              style: TextStyle(color: Colors.white38, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Panel Sheet Chrome ───────────────────────────────────────────────────────

class _PanelSheet extends StatelessWidget {
  const _PanelSheet({required this.child, required this.onClose, this.title});

  final Widget child;
  final VoidCallback onClose;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xF0111111),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          children: [
            // Handle
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Container(
                width: 28,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header row (if title given)
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 12, 8),
                child: Row(
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
            ] else
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12, top: 4),
                  child: GestureDetector(
                    onTap: onClose,
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white54,
                      size: 20,
                    ),
                  ),
                ),
              ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
