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
  }) = _MediaItem;

  factory MediaItem.fromJson(Map<String, dynamic> json) =>
      _$MediaItemFromJson(json);
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
