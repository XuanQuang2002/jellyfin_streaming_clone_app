// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChapterInfo _$ChapterInfoFromJson(Map<String, dynamic> json) => _ChapterInfo(
  startPositionTicks: (json['StartPositionTicks'] as num).toInt(),
  name: json['Name'] as String?,
  imageTag: json['ImageTag'] as String?,
);

Map<String, dynamic> _$ChapterInfoToJson(_ChapterInfo instance) =>
    <String, dynamic>{
      'StartPositionTicks': instance.startPositionTicks,
      'Name': instance.name,
      'ImageTag': instance.imageTag,
    };

_PlayerItemDetail _$PlayerItemDetailFromJson(Map<String, dynamic> json) =>
    _PlayerItemDetail(
      id: json['Id'] as String,
      name: json['Name'] as String,
      type: json['Type'] as String,
      runTimeTicks: (json['RunTimeTicks'] as num?)?.toInt(),
      chapters:
          (json['Chapters'] as List<dynamic>?)
              ?.map((e) => ChapterInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PlayerItemDetailToJson(_PlayerItemDetail instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Type': instance.type,
      'RunTimeTicks': instance.runTimeTicks,
      'Chapters': instance.chapters,
    };
