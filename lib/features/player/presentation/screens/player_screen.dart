import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import '../../../auth/domain/providers/auth_provider.dart';
import '../../../library/data/models/library_models.dart';
import '../../../library/domain/providers/library_provider.dart';
import '../widgets/player_chapters_panel.dart';
import '../widgets/player_controls_overlay.dart';
import '../widgets/player_episodes_panel.dart';
import '../widgets/player_info_panel.dart';
import '../widgets/player_settings_panel.dart';

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
          logLevel: MPVLogLevel.warn,
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

    useEffect(() {
      if (playing.data == true) scheduleHide();
      return null;
    }, [playing.data]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final panelH = constraints.maxHeight * 0.65;

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
              // if (playerError.value != null)
              //   Center(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 32),
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           const Icon(
              //             Icons.error_outline_rounded,
              //             color: Colors.redAccent,
              //             size: 48,
              //           ),
              //           const SizedBox(height: 12),
              //           const Text(
              //             'Playback error',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //           const SizedBox(height: 6),
              //           Text(
              //             playerError.value!,
              //             textAlign: TextAlign.center,
              //             style: const TextStyle(
              //               color: Colors.white70,
              //               fontSize: 12,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),

              // ── Background tap handler ─────────────────────────────────────
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  if (activePanel.value != _Panel.none) {
                    closePanel();
                  } else if (controlsVisible.value) {
                    controlsVisible.value = false;
                    hideTimerRef.value?.cancel();
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
                  child: PlayerControlsOverlay(
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

              // ── Panel dismiss overlay ──────────────────────────────────────
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
                  child: PlayerSettingsPanel(
                    player: player,
                    onClose: closePanel,
                  ),
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
                    child: PlayerInfoPanel(item: item, onClose: closePanel),
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
                    child: PlayerEpisodesPanel(
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
                    child: PlayerChaptersPanel(
                      player: player,
                      itemId: currentItemId.value,
                      serverUrl: auth?.serverUrl ?? '',
                      onClose: closePanel,
                    ),
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
