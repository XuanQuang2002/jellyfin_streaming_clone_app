// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChapterInfo {

/// Start position in ticks (1 tick = 100 ns).
@JsonKey(name: 'StartPositionTicks') int get startPositionTicks;@JsonKey(name: 'Name') String? get name;@JsonKey(name: 'ImageTag') String? get imageTag;
/// Create a copy of ChapterInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterInfoCopyWith<ChapterInfo> get copyWith => _$ChapterInfoCopyWithImpl<ChapterInfo>(this as ChapterInfo, _$identity);

  /// Serializes this ChapterInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterInfo&&(identical(other.startPositionTicks, startPositionTicks) || other.startPositionTicks == startPositionTicks)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageTag, imageTag) || other.imageTag == imageTag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startPositionTicks,name,imageTag);

@override
String toString() {
  return 'ChapterInfo(startPositionTicks: $startPositionTicks, name: $name, imageTag: $imageTag)';
}


}

/// @nodoc
abstract mixin class $ChapterInfoCopyWith<$Res>  {
  factory $ChapterInfoCopyWith(ChapterInfo value, $Res Function(ChapterInfo) _then) = _$ChapterInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'StartPositionTicks') int startPositionTicks,@JsonKey(name: 'Name') String? name,@JsonKey(name: 'ImageTag') String? imageTag
});




}
/// @nodoc
class _$ChapterInfoCopyWithImpl<$Res>
    implements $ChapterInfoCopyWith<$Res> {
  _$ChapterInfoCopyWithImpl(this._self, this._then);

  final ChapterInfo _self;
  final $Res Function(ChapterInfo) _then;

/// Create a copy of ChapterInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startPositionTicks = null,Object? name = freezed,Object? imageTag = freezed,}) {
  return _then(_self.copyWith(
startPositionTicks: null == startPositionTicks ? _self.startPositionTicks : startPositionTicks // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,imageTag: freezed == imageTag ? _self.imageTag : imageTag // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterInfo].
extension ChapterInfoPatterns on ChapterInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterInfo value)  $default,){
final _that = this;
switch (_that) {
case _ChapterInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'StartPositionTicks')  int startPositionTicks, @JsonKey(name: 'Name')  String? name, @JsonKey(name: 'ImageTag')  String? imageTag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterInfo() when $default != null:
return $default(_that.startPositionTicks,_that.name,_that.imageTag);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'StartPositionTicks')  int startPositionTicks, @JsonKey(name: 'Name')  String? name, @JsonKey(name: 'ImageTag')  String? imageTag)  $default,) {final _that = this;
switch (_that) {
case _ChapterInfo():
return $default(_that.startPositionTicks,_that.name,_that.imageTag);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'StartPositionTicks')  int startPositionTicks, @JsonKey(name: 'Name')  String? name, @JsonKey(name: 'ImageTag')  String? imageTag)?  $default,) {final _that = this;
switch (_that) {
case _ChapterInfo() when $default != null:
return $default(_that.startPositionTicks,_that.name,_that.imageTag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChapterInfo implements ChapterInfo {
  const _ChapterInfo({@JsonKey(name: 'StartPositionTicks') required this.startPositionTicks, @JsonKey(name: 'Name') this.name, @JsonKey(name: 'ImageTag') this.imageTag});
  factory _ChapterInfo.fromJson(Map<String, dynamic> json) => _$ChapterInfoFromJson(json);

/// Start position in ticks (1 tick = 100 ns).
@override@JsonKey(name: 'StartPositionTicks') final  int startPositionTicks;
@override@JsonKey(name: 'Name') final  String? name;
@override@JsonKey(name: 'ImageTag') final  String? imageTag;

/// Create a copy of ChapterInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterInfoCopyWith<_ChapterInfo> get copyWith => __$ChapterInfoCopyWithImpl<_ChapterInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterInfo&&(identical(other.startPositionTicks, startPositionTicks) || other.startPositionTicks == startPositionTicks)&&(identical(other.name, name) || other.name == name)&&(identical(other.imageTag, imageTag) || other.imageTag == imageTag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startPositionTicks,name,imageTag);

@override
String toString() {
  return 'ChapterInfo(startPositionTicks: $startPositionTicks, name: $name, imageTag: $imageTag)';
}


}

/// @nodoc
abstract mixin class _$ChapterInfoCopyWith<$Res> implements $ChapterInfoCopyWith<$Res> {
  factory _$ChapterInfoCopyWith(_ChapterInfo value, $Res Function(_ChapterInfo) _then) = __$ChapterInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'StartPositionTicks') int startPositionTicks,@JsonKey(name: 'Name') String? name,@JsonKey(name: 'ImageTag') String? imageTag
});




}
/// @nodoc
class __$ChapterInfoCopyWithImpl<$Res>
    implements _$ChapterInfoCopyWith<$Res> {
  __$ChapterInfoCopyWithImpl(this._self, this._then);

  final _ChapterInfo _self;
  final $Res Function(_ChapterInfo) _then;

/// Create a copy of ChapterInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startPositionTicks = null,Object? name = freezed,Object? imageTag = freezed,}) {
  return _then(_ChapterInfo(
startPositionTicks: null == startPositionTicks ? _self.startPositionTicks : startPositionTicks // ignore: cast_nullable_to_non_nullable
as int,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,imageTag: freezed == imageTag ? _self.imageTag : imageTag // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PlayerItemDetail {

@JsonKey(name: 'Id') String get id;@JsonKey(name: 'Name') String get name;@JsonKey(name: 'Type') String get type;@JsonKey(name: 'RunTimeTicks') int? get runTimeTicks;@JsonKey(name: 'Chapters') List<ChapterInfo> get chapters;
/// Create a copy of PlayerItemDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerItemDetailCopyWith<PlayerItemDetail> get copyWith => _$PlayerItemDetailCopyWithImpl<PlayerItemDetail>(this as PlayerItemDetail, _$identity);

  /// Serializes this PlayerItemDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerItemDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.runTimeTicks, runTimeTicks) || other.runTimeTicks == runTimeTicks)&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,runTimeTicks,const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'PlayerItemDetail(id: $id, name: $name, type: $type, runTimeTicks: $runTimeTicks, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $PlayerItemDetailCopyWith<$Res>  {
  factory $PlayerItemDetailCopyWith(PlayerItemDetail value, $Res Function(PlayerItemDetail) _then) = _$PlayerItemDetailCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'Type') String type,@JsonKey(name: 'RunTimeTicks') int? runTimeTicks,@JsonKey(name: 'Chapters') List<ChapterInfo> chapters
});




}
/// @nodoc
class _$PlayerItemDetailCopyWithImpl<$Res>
    implements $PlayerItemDetailCopyWith<$Res> {
  _$PlayerItemDetailCopyWithImpl(this._self, this._then);

  final PlayerItemDetail _self;
  final $Res Function(PlayerItemDetail) _then;

/// Create a copy of PlayerItemDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? runTimeTicks = freezed,Object? chapters = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,runTimeTicks: freezed == runTimeTicks ? _self.runTimeTicks : runTimeTicks // ignore: cast_nullable_to_non_nullable
as int?,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerItemDetail].
extension PlayerItemDetailPatterns on PlayerItemDetail {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerItemDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerItemDetail() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerItemDetail value)  $default,){
final _that = this;
switch (_that) {
case _PlayerItemDetail():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerItemDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerItemDetail() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Type')  String type, @JsonKey(name: 'RunTimeTicks')  int? runTimeTicks, @JsonKey(name: 'Chapters')  List<ChapterInfo> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerItemDetail() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.runTimeTicks,_that.chapters);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Type')  String type, @JsonKey(name: 'RunTimeTicks')  int? runTimeTicks, @JsonKey(name: 'Chapters')  List<ChapterInfo> chapters)  $default,) {final _that = this;
switch (_that) {
case _PlayerItemDetail():
return $default(_that.id,_that.name,_that.type,_that.runTimeTicks,_that.chapters);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Type')  String type, @JsonKey(name: 'RunTimeTicks')  int? runTimeTicks, @JsonKey(name: 'Chapters')  List<ChapterInfo> chapters)?  $default,) {final _that = this;
switch (_that) {
case _PlayerItemDetail() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.runTimeTicks,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerItemDetail implements PlayerItemDetail {
  const _PlayerItemDetail({@JsonKey(name: 'Id') required this.id, @JsonKey(name: 'Name') required this.name, @JsonKey(name: 'Type') required this.type, @JsonKey(name: 'RunTimeTicks') this.runTimeTicks, @JsonKey(name: 'Chapters') final  List<ChapterInfo> chapters = const []}): _chapters = chapters;
  factory _PlayerItemDetail.fromJson(Map<String, dynamic> json) => _$PlayerItemDetailFromJson(json);

@override@JsonKey(name: 'Id') final  String id;
@override@JsonKey(name: 'Name') final  String name;
@override@JsonKey(name: 'Type') final  String type;
@override@JsonKey(name: 'RunTimeTicks') final  int? runTimeTicks;
 final  List<ChapterInfo> _chapters;
@override@JsonKey(name: 'Chapters') List<ChapterInfo> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of PlayerItemDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerItemDetailCopyWith<_PlayerItemDetail> get copyWith => __$PlayerItemDetailCopyWithImpl<_PlayerItemDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerItemDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerItemDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.runTimeTicks, runTimeTicks) || other.runTimeTicks == runTimeTicks)&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,runTimeTicks,const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'PlayerItemDetail(id: $id, name: $name, type: $type, runTimeTicks: $runTimeTicks, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$PlayerItemDetailCopyWith<$Res> implements $PlayerItemDetailCopyWith<$Res> {
  factory _$PlayerItemDetailCopyWith(_PlayerItemDetail value, $Res Function(_PlayerItemDetail) _then) = __$PlayerItemDetailCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'Type') String type,@JsonKey(name: 'RunTimeTicks') int? runTimeTicks,@JsonKey(name: 'Chapters') List<ChapterInfo> chapters
});




}
/// @nodoc
class __$PlayerItemDetailCopyWithImpl<$Res>
    implements _$PlayerItemDetailCopyWith<$Res> {
  __$PlayerItemDetailCopyWithImpl(this._self, this._then);

  final _PlayerItemDetail _self;
  final $Res Function(_PlayerItemDetail) _then;

/// Create a copy of PlayerItemDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? runTimeTicks = freezed,Object? chapters = null,}) {
  return _then(_PlayerItemDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,runTimeTicks: freezed == runTimeTicks ? _self.runTimeTicks : runTimeTicks // ignore: cast_nullable_to_non_nullable
as int?,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterInfo>,
  ));
}


}

// dart format on
