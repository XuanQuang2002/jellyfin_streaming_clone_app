// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserView _$UserViewFromJson(Map<String, dynamic> json) => _UserView(
  id: json['Id'] as String,
  name: json['Name'] as String,
  collectionType: json['CollectionType'] as String?,
  serverId: json['ServerId'] as String?,
  imageTags: (json['ImageTags'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$UserViewToJson(_UserView instance) => <String, dynamic>{
  'Id': instance.id,
  'Name': instance.name,
  'CollectionType': instance.collectionType,
  'ServerId': instance.serverId,
  'ImageTags': instance.imageTags,
};

_UserViewsResponse _$UserViewsResponseFromJson(Map<String, dynamic> json) =>
    _UserViewsResponse(
      items: (json['Items'] as List<dynamic>)
          .map((e) => UserView.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecordCount: (json['TotalRecordCount'] as num).toInt(),
    );

Map<String, dynamic> _$UserViewsResponseToJson(_UserViewsResponse instance) =>
    <String, dynamic>{
      'Items': instance.items,
      'TotalRecordCount': instance.totalRecordCount,
    };

_MediaItem _$MediaItemFromJson(Map<String, dynamic> json) => _MediaItem(
  id: json['Id'] as String,
  name: json['Name'] as String,
  type: json['Type'] as String,
  serverId: json['ServerId'] as String?,
  productionYear: (json['ProductionYear'] as num?)?.toInt(),
  communityRating: (json['CommunityRating'] as num?)?.toDouble(),
  imageTags: (json['ImageTags'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  backdropImageTags: (json['BackdropImageTags'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  overview: json['Overview'] as String?,
  runTimeTicks: (json['RunTimeTicks'] as num?)?.toInt(),
  officialRating: json['OfficialRating'] as String?,
  genres: (json['Genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  taglines: (json['Taglines'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  indexNumber: (json['IndexNumber'] as num?)?.toInt(),
  parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
  seriesId: json['SeriesId'] as String?,
  seriesName: json['SeriesName'] as String?,
  seasonId: json['SeasonId'] as String?,
  seasonName: json['SeasonName'] as String?,
);

Map<String, dynamic> _$MediaItemToJson(_MediaItem instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Type': instance.type,
      'ServerId': instance.serverId,
      'ProductionYear': instance.productionYear,
      'CommunityRating': instance.communityRating,
      'ImageTags': instance.imageTags,
      'BackdropImageTags': instance.backdropImageTags,
      'Overview': instance.overview,
      'RunTimeTicks': instance.runTimeTicks,
      'OfficialRating': instance.officialRating,
      'Genres': instance.genres,
      'Taglines': instance.taglines,
      'IndexNumber': instance.indexNumber,
      'ParentIndexNumber': instance.parentIndexNumber,
      'SeriesId': instance.seriesId,
      'SeriesName': instance.seriesName,
      'SeasonId': instance.seasonId,
      'SeasonName': instance.seasonName,
    };

_MediaItemsResponse _$MediaItemsResponseFromJson(Map<String, dynamic> json) =>
    _MediaItemsResponse(
      items: (json['Items'] as List<dynamic>)
          .map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecordCount: (json['TotalRecordCount'] as num).toInt(),
      startIndex: (json['StartIndex'] as num).toInt(),
    );

Map<String, dynamic> _$MediaItemsResponseToJson(_MediaItemsResponse instance) =>
    <String, dynamic>{
      'Items': instance.items,
      'TotalRecordCount': instance.totalRecordCount,
      'StartIndex': instance.startIndex,
    };

_SeasonItem _$SeasonItemFromJson(Map<String, dynamic> json) => _SeasonItem(
  id: json['Id'] as String,
  name: json['Name'] as String,
  indexNumber: (json['IndexNumber'] as num?)?.toInt(),
  seriesId: json['SeriesId'] as String?,
  imageTags: (json['ImageTags'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  childCount: (json['ChildCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$SeasonItemToJson(_SeasonItem instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'IndexNumber': instance.indexNumber,
      'SeriesId': instance.seriesId,
      'ImageTags': instance.imageTags,
      'ChildCount': instance.childCount,
    };

_SeasonsResponse _$SeasonsResponseFromJson(Map<String, dynamic> json) =>
    _SeasonsResponse(
      items: (json['Items'] as List<dynamic>)
          .map((e) => SeasonItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecordCount: (json['TotalRecordCount'] as num).toInt(),
    );

Map<String, dynamic> _$SeasonsResponseToJson(_SeasonsResponse instance) =>
    <String, dynamic>{
      'Items': instance.items,
      'TotalRecordCount': instance.totalRecordCount,
    };

_EpisodeItem _$EpisodeItemFromJson(Map<String, dynamic> json) => _EpisodeItem(
  id: json['Id'] as String,
  name: json['Name'] as String,
  indexNumber: (json['IndexNumber'] as num?)?.toInt(),
  parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
  overview: json['Overview'] as String?,
  runTimeTicks: (json['RunTimeTicks'] as num?)?.toInt(),
  imageTags: (json['ImageTags'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  backdropImageTags: (json['BackdropImageTags'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  seriesId: json['SeriesId'] as String?,
  seasonId: json['SeasonId'] as String?,
);

Map<String, dynamic> _$EpisodeItemToJson(_EpisodeItem instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'IndexNumber': instance.indexNumber,
      'ParentIndexNumber': instance.parentIndexNumber,
      'Overview': instance.overview,
      'RunTimeTicks': instance.runTimeTicks,
      'ImageTags': instance.imageTags,
      'BackdropImageTags': instance.backdropImageTags,
      'SeriesId': instance.seriesId,
      'SeasonId': instance.seasonId,
    };

_EpisodesResponse _$EpisodesResponseFromJson(Map<String, dynamic> json) =>
    _EpisodesResponse(
      items: (json['Items'] as List<dynamic>)
          .map((e) => EpisodeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRecordCount: (json['TotalRecordCount'] as num).toInt(),
    );

Map<String, dynamic> _$EpisodesResponseToJson(_EpisodesResponse instance) =>
    <String, dynamic>{
      'Items': instance.items,
      'TotalRecordCount': instance.totalRecordCount,
    };
