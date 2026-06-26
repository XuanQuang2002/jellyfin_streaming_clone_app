import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_model.freezed.dart';
part 'player_model.g.dart';

// ─── Chapter Info ─────────────────────────────────────────────────────────────

@freezed
abstract class ChapterInfo with _$ChapterInfo {
  const factory ChapterInfo({
    /// Start position in ticks (1 tick = 100 ns).
    @JsonKey(name: 'StartPositionTicks') required int startPositionTicks,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'ImageTag') String? imageTag,
  }) = _ChapterInfo;

  factory ChapterInfo.fromJson(Map<String, dynamic> json) =>
      _$ChapterInfoFromJson(json);
}

// ─── Item Detail with Chapters ────────────────────────────────────────────────

@freezed
abstract class PlayerItemDetail with _$PlayerItemDetail {
  const factory PlayerItemDetail({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'RunTimeTicks') int? runTimeTicks,
    @JsonKey(name: 'Chapters') @Default([]) List<ChapterInfo> chapters,
  }) = _PlayerItemDetail;

  factory PlayerItemDetail.fromJson(Map<String, dynamic> json) =>
      _$PlayerItemDetailFromJson(json);
}
