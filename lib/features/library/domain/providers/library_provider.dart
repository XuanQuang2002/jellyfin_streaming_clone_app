import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/domain/providers/auth_provider.dart';
import '../../data/models/library_models.dart';
import '../../data/repositories/library_repository.dart';

// ─── Repository ───────────────────────────────────────────────────────────────

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  return LibraryRepository(ref.watch(dioProvider));
});

// ─── User Views ───────────────────────────────────────────────────────────────

final userViewsProvider = FutureProvider.autoDispose<List<UserView>>((ref) async {
  final auth = ref.watch(authenticatedStateProvider);
  if (auth == null) return [];
  final repo = ref.watch(libraryRepositoryProvider);
  final response = await repo.getUserViews(auth.userId);
  return response.items;
});

// ─── Continue Watching (Resume) ───────────────────────────────────────────────

final continueWatchingProvider = FutureProvider.autoDispose<List<MediaItem>>((
  ref,
) async {
  final auth = ref.watch(authenticatedStateProvider);
  if (auth == null) return [];
  final repo = ref.watch(libraryRepositoryProvider);
  final response = await repo.getResumeItems(userId: auth.userId);
  return response.items;
});

// ─── Next Up (TV Shows) ───────────────────────────────────────────────────────

final nextUpProvider = FutureProvider.autoDispose<List<MediaItem>>((ref) async {
  final auth = ref.watch(authenticatedStateProvider);
  if (auth == null) return [];
  final repo = ref.watch(libraryRepositoryProvider);
  final response = await repo.getNextUpItems(userId: auth.userId);
  return response.items;
});

// ─── Library Items (paginated) ────────────────────────────────────────────────

class LibraryItemsState {
  const LibraryItemsState({
    this.items = const [],
    this.isLoadingMore = false,
    this.hasMore = true,
    this.totalCount = 0,
  });

  final List<MediaItem> items;
  final bool isLoadingMore;
  final bool hasMore;
  final int totalCount;

  LibraryItemsState copyWith({
    List<MediaItem>? items,
    bool? isLoadingMore,
    bool? hasMore,
    int? totalCount,
  }) {
    return LibraryItemsState(
      items: items ?? this.items,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

// In Riverpod 3.x, family notifiers receive the arg via constructor.
// The notifier extends AsyncNotifier<State> (not FamilyAsyncNotifier).
class LibraryItemsNotifier extends AsyncNotifier<LibraryItemsState> {
  LibraryItemsNotifier(this.libraryId);

  final String libraryId;
  static const _pageSize = 30;

  @override
  Future<LibraryItemsState> build() async {
    final auth = ref.watch(authenticatedStateProvider);
    if (auth == null) return const LibraryItemsState(hasMore: false);

    final repo = ref.watch(libraryRepositoryProvider);
    final response = await repo.getLibraryItems(
      userId: auth.userId,
      parentId: libraryId,
      startIndex: 0,
      limit: _pageSize,
    );

    return LibraryItemsState(
      items: response.items,
      hasMore: response.items.length < response.totalRecordCount,
      totalCount: response.totalRecordCount,
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    final auth = ref.read(authenticatedStateProvider);
    if (auth == null) return;

    try {
      final repo = ref.read(libraryRepositoryProvider);
      final response = await repo.getLibraryItems(
        userId: auth.userId,
        parentId: libraryId,
        startIndex: current.items.length,
        limit: _pageSize,
      );

      final allItems = [...current.items, ...response.items];
      state = AsyncData(
        LibraryItemsState(
          items: allItems,
          hasMore: allItems.length < response.totalRecordCount,
          totalCount: response.totalRecordCount,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }
}

// Riverpod 3.x family: factory fn receives the arg and constructs the notifier.
final libraryItemsProvider = AsyncNotifierProvider.autoDispose
    .family<LibraryItemsNotifier, LibraryItemsState, String>(
  (arg) => LibraryItemsNotifier(arg),
);

// ─── Item Detail ──────────────────────────────────────────────────────────────

final mediaItemDetailProvider = FutureProvider.autoDispose
    .family<MediaItem, String>((ref, itemId) async {
  final auth = ref.watch(authenticatedStateProvider);
  if (auth == null) throw const UnknownException();
  final repo = ref.watch(libraryRepositoryProvider);
  return repo.getItemDetail(userId: auth.userId, itemId: itemId);
});

// ─── Seasons ─────────────────────────────────────────────────────────────────

final seasonsProvider = FutureProvider.autoDispose
    .family<List<SeasonItem>, String>((ref, seriesId) async {
  final auth = ref.watch(authenticatedStateProvider);
  if (auth == null) return [];
  final repo = ref.watch(libraryRepositoryProvider);
  final response = await repo.getSeasons(userId: auth.userId, seriesId: seriesId);
  return response.items;
});

// ─── Episodes ─────────────────────────────────────────────────────────────────

typedef EpisodesParams = ({String seriesId, String seasonId});

final episodesProvider = FutureProvider.autoDispose
    .family<List<EpisodeItem>, EpisodesParams>((ref, params) async {
  final auth = ref.watch(authenticatedStateProvider);
  if (auth == null) return [];
  final repo = ref.watch(libraryRepositoryProvider);
  final response = await repo.getEpisodes(
    userId: auth.userId,
    seriesId: params.seriesId,
    seasonId: params.seasonId,
  );
  return response.items;
});
