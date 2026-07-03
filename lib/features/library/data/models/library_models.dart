import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_models.freezed.dart';
part 'library_models.g.dart';

// ─── User View (Library) ──────────────────────────────────────────────────────

@freezed
abstract class UserView with _$UserView {
  const factory UserView({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'CollectionType') String? collectionType,
    @JsonKey(name: 'ServerId') String? serverId,
    @JsonKey(name: 'ImageTags') Map<String, String>? imageTags,
  }) = _UserView;

  factory UserView.fromJson(Map<String, dynamic> json) =>
      _$UserViewFromJson(json);
}

@freezed
abstract class UserViewsResponse with _$UserViewsResponse {
  const factory UserViewsResponse({
    @JsonKey(name: 'Items') required List<UserView> items,
    @JsonKey(name: 'TotalRecordCount') required int totalRecordCount,
  }) = _UserViewsResponse;

  factory UserViewsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserViewsResponseFromJson(json);
}

// ─── Media Item ───────────────────────────────────────────────────────────────

@freezed
abstract class MediaItem with _$MediaItem {
  const factory MediaItem({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'ServerId') String? serverId,
    @JsonKey(name: 'ProductionYear') int? productionYear,
    @JsonKey(name: 'CommunityRating') double? communityRating,
    @JsonKey(name: 'ImageTags') Map<String, String>? imageTags,
    @JsonKey(name: 'BackdropImageTags') List<String>? backdropImageTags,
    @JsonKey(name: 'Overview') String? overview,
    @JsonKey(name: 'RunTimeTicks') int? runTimeTicks,
    @JsonKey(name: 'OfficialRating') String? officialRating,
    @JsonKey(name: 'Genres') List<String>? genres,
    @JsonKey(name: 'Taglines') List<String>? taglines,
    // Episode-specific
    @JsonKey(name: 'IndexNumber') int? indexNumber,
    @JsonKey(name: 'ParentIndexNumber') int? parentIndexNumber,
    @JsonKey(name: 'SeriesId') String? seriesId,
    @JsonKey(name: 'SeriesName') String? seriesName,
    @JsonKey(name: 'SeasonId') String? seasonId,
    @JsonKey(name: 'SeasonName') String? seasonName,
    // Playback state (resume support)
    @JsonKey(name: 'UserData') UserItemData? userData,
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);
}

// ─── User Item Data (playback state) ──────────────────────────────────────────

@freezed
abstract class UserItemData with _$UserItemData {
  const factory UserItemData({
    @JsonKey(name: 'PlaybackPositionTicks') int? playbackPositionTicks,
    @JsonKey(name: 'PlayedPercentage') double? playedPercentage,
    @JsonKey(name: 'Played') bool? played,
  }) = _UserItemData;

  factory UserItemData.fromJson(Map<String, dynamic> json) =>
      _$UserItemDataFromJson(json);
}

@freezed
abstract class MediaItemsResponse with _$MediaItemsResponse {
  const factory MediaItemsResponse({
    @JsonKey(name: 'Items') required List<MediaItem> items,
    @JsonKey(name: 'TotalRecordCount') required int totalRecordCount,
    @JsonKey(name: 'StartIndex') required int startIndex,
  }) = _MediaItemsResponse;

  factory MediaItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaItemsResponseFromJson(json);
}

// ─── Season ───────────────────────────────────────────────────────────────────

@freezed
abstract class SeasonItem with _$SeasonItem {
  const factory SeasonItem({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'IndexNumber') int? indexNumber,
    @JsonKey(name: 'SeriesId') String? seriesId,
    @JsonKey(name: 'ImageTags') Map<String, String>? imageTags,
    @JsonKey(name: 'ChildCount') int? childCount,
  }) = _SeasonItem;

  factory SeasonItem.fromJson(Map<String, dynamic> json) =>
      _$SeasonItemFromJson(json);
}

@freezed
abstract class SeasonsResponse with _$SeasonsResponse {
  const factory SeasonsResponse({
    @JsonKey(name: 'Items') required List<SeasonItem> items,
    @JsonKey(name: 'TotalRecordCount') required int totalRecordCount,
  }) = _SeasonsResponse;

  factory SeasonsResponse.fromJson(Map<String, dynamic> json) =>
      _$SeasonsResponseFromJson(json);
}

// ─── Episode ──────────────────────────────────────────────────────────────────

@freezed
abstract class EpisodeItem with _$EpisodeItem {
  const factory EpisodeItem({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'IndexNumber') int? indexNumber,
    @JsonKey(name: 'ParentIndexNumber') int? parentIndexNumber,
    @JsonKey(name: 'Overview') String? overview,
    @JsonKey(name: 'RunTimeTicks') int? runTimeTicks,
    @JsonKey(name: 'ImageTags') Map<String, String>? imageTags,
    @JsonKey(name: 'BackdropImageTags') List<String>? backdropImageTags,
    @JsonKey(name: 'SeriesId') String? seriesId,
    @JsonKey(name: 'SeasonId') String? seasonId,
  }) = _EpisodeItem;

  factory EpisodeItem.fromJson(Map<String, dynamic> json) =>
      _$EpisodeItemFromJson(json);
}

@freezed
abstract class EpisodesResponse with _$EpisodesResponse {
  const factory EpisodesResponse({
    @JsonKey(name: 'Items') required List<EpisodeItem> items,
    @JsonKey(name: 'TotalRecordCount') required int totalRecordCount,
  }) = _EpisodesResponse;

  factory EpisodesResponse.fromJson(Map<String, dynamic> json) =>
      _$EpisodesResponseFromJson(json);
}
