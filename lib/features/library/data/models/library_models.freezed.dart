// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserView {

@JsonKey(name: 'Id') String get id;@JsonKey(name: 'Name') String get name;@JsonKey(name: 'CollectionType') String? get collectionType;@JsonKey(name: 'ServerId') String? get serverId;@JsonKey(name: 'ImageTags') Map<String, String>? get imageTags;
/// Create a copy of UserView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserViewCopyWith<UserView> get copyWith => _$UserViewCopyWithImpl<UserView>(this as UserView, _$identity);

  /// Serializes this UserView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserView&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.collectionType, collectionType) || other.collectionType == collectionType)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&const DeepCollectionEquality().equals(other.imageTags, imageTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,collectionType,serverId,const DeepCollectionEquality().hash(imageTags));

@override
String toString() {
  return 'UserView(id: $id, name: $name, collectionType: $collectionType, serverId: $serverId, imageTags: $imageTags)';
}


}

/// @nodoc
abstract mixin class $UserViewCopyWith<$Res>  {
  factory $UserViewCopyWith(UserView value, $Res Function(UserView) _then) = _$UserViewCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'CollectionType') String? collectionType,@JsonKey(name: 'ServerId') String? serverId,@JsonKey(name: 'ImageTags') Map<String, String>? imageTags
});




}
/// @nodoc
class _$UserViewCopyWithImpl<$Res>
    implements $UserViewCopyWith<$Res> {
  _$UserViewCopyWithImpl(this._self, this._then);

  final UserView _self;
  final $Res Function(UserView) _then;

/// Create a copy of UserView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? collectionType = freezed,Object? serverId = freezed,Object? imageTags = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,collectionType: freezed == collectionType ? _self.collectionType : collectionType // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,imageTags: freezed == imageTags ? _self.imageTags : imageTags // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserView].
extension UserViewPatterns on UserView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserView value)  $default,){
final _that = this;
switch (_that) {
case _UserView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserView value)?  $default,){
final _that = this;
switch (_that) {
case _UserView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'CollectionType')  String? collectionType, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'ImageTags')  Map<String, String>? imageTags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserView() when $default != null:
return $default(_that.id,_that.name,_that.collectionType,_that.serverId,_that.imageTags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'CollectionType')  String? collectionType, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'ImageTags')  Map<String, String>? imageTags)  $default,) {final _that = this;
switch (_that) {
case _UserView():
return $default(_that.id,_that.name,_that.collectionType,_that.serverId,_that.imageTags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'CollectionType')  String? collectionType, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'ImageTags')  Map<String, String>? imageTags)?  $default,) {final _that = this;
switch (_that) {
case _UserView() when $default != null:
return $default(_that.id,_that.name,_that.collectionType,_that.serverId,_that.imageTags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserView implements UserView {
  const _UserView({@JsonKey(name: 'Id') required this.id, @JsonKey(name: 'Name') required this.name, @JsonKey(name: 'CollectionType') this.collectionType, @JsonKey(name: 'ServerId') this.serverId, @JsonKey(name: 'ImageTags') final  Map<String, String>? imageTags}): _imageTags = imageTags;
  factory _UserView.fromJson(Map<String, dynamic> json) => _$UserViewFromJson(json);

@override@JsonKey(name: 'Id') final  String id;
@override@JsonKey(name: 'Name') final  String name;
@override@JsonKey(name: 'CollectionType') final  String? collectionType;
@override@JsonKey(name: 'ServerId') final  String? serverId;
 final  Map<String, String>? _imageTags;
@override@JsonKey(name: 'ImageTags') Map<String, String>? get imageTags {
  final value = _imageTags;
  if (value == null) return null;
  if (_imageTags is EqualUnmodifiableMapView) return _imageTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of UserView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserViewCopyWith<_UserView> get copyWith => __$UserViewCopyWithImpl<_UserView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserViewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserView&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.collectionType, collectionType) || other.collectionType == collectionType)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&const DeepCollectionEquality().equals(other._imageTags, _imageTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,collectionType,serverId,const DeepCollectionEquality().hash(_imageTags));

@override
String toString() {
  return 'UserView(id: $id, name: $name, collectionType: $collectionType, serverId: $serverId, imageTags: $imageTags)';
}


}

/// @nodoc
abstract mixin class _$UserViewCopyWith<$Res> implements $UserViewCopyWith<$Res> {
  factory _$UserViewCopyWith(_UserView value, $Res Function(_UserView) _then) = __$UserViewCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'CollectionType') String? collectionType,@JsonKey(name: 'ServerId') String? serverId,@JsonKey(name: 'ImageTags') Map<String, String>? imageTags
});




}
/// @nodoc
class __$UserViewCopyWithImpl<$Res>
    implements _$UserViewCopyWith<$Res> {
  __$UserViewCopyWithImpl(this._self, this._then);

  final _UserView _self;
  final $Res Function(_UserView) _then;

/// Create a copy of UserView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? collectionType = freezed,Object? serverId = freezed,Object? imageTags = freezed,}) {
  return _then(_UserView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,collectionType: freezed == collectionType ? _self.collectionType : collectionType // ignore: cast_nullable_to_non_nullable
as String?,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,imageTags: freezed == imageTags ? _self._imageTags : imageTags // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}


/// @nodoc
mixin _$UserViewsResponse {

@JsonKey(name: 'Items') List<UserView> get items;@JsonKey(name: 'TotalRecordCount') int get totalRecordCount;
/// Create a copy of UserViewsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserViewsResponseCopyWith<UserViewsResponse> get copyWith => _$UserViewsResponseCopyWithImpl<UserViewsResponse>(this as UserViewsResponse, _$identity);

  /// Serializes this UserViewsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserViewsResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalRecordCount, totalRecordCount) || other.totalRecordCount == totalRecordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalRecordCount);

@override
String toString() {
  return 'UserViewsResponse(items: $items, totalRecordCount: $totalRecordCount)';
}


}

/// @nodoc
abstract mixin class $UserViewsResponseCopyWith<$Res>  {
  factory $UserViewsResponseCopyWith(UserViewsResponse value, $Res Function(UserViewsResponse) _then) = _$UserViewsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Items') List<UserView> items,@JsonKey(name: 'TotalRecordCount') int totalRecordCount
});




}
/// @nodoc
class _$UserViewsResponseCopyWithImpl<$Res>
    implements $UserViewsResponseCopyWith<$Res> {
  _$UserViewsResponseCopyWithImpl(this._self, this._then);

  final UserViewsResponse _self;
  final $Res Function(UserViewsResponse) _then;

/// Create a copy of UserViewsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalRecordCount = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<UserView>,totalRecordCount: null == totalRecordCount ? _self.totalRecordCount : totalRecordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserViewsResponse].
extension UserViewsResponsePatterns on UserViewsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserViewsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserViewsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserViewsResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserViewsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserViewsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserViewsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Items')  List<UserView> items, @JsonKey(name: 'TotalRecordCount')  int totalRecordCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserViewsResponse() when $default != null:
return $default(_that.items,_that.totalRecordCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Items')  List<UserView> items, @JsonKey(name: 'TotalRecordCount')  int totalRecordCount)  $default,) {final _that = this;
switch (_that) {
case _UserViewsResponse():
return $default(_that.items,_that.totalRecordCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Items')  List<UserView> items, @JsonKey(name: 'TotalRecordCount')  int totalRecordCount)?  $default,) {final _that = this;
switch (_that) {
case _UserViewsResponse() when $default != null:
return $default(_that.items,_that.totalRecordCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserViewsResponse implements UserViewsResponse {
  const _UserViewsResponse({@JsonKey(name: 'Items') required final  List<UserView> items, @JsonKey(name: 'TotalRecordCount') required this.totalRecordCount}): _items = items;
  factory _UserViewsResponse.fromJson(Map<String, dynamic> json) => _$UserViewsResponseFromJson(json);

 final  List<UserView> _items;
@override@JsonKey(name: 'Items') List<UserView> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'TotalRecordCount') final  int totalRecordCount;

/// Create a copy of UserViewsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserViewsResponseCopyWith<_UserViewsResponse> get copyWith => __$UserViewsResponseCopyWithImpl<_UserViewsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserViewsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserViewsResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalRecordCount, totalRecordCount) || other.totalRecordCount == totalRecordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalRecordCount);

@override
String toString() {
  return 'UserViewsResponse(items: $items, totalRecordCount: $totalRecordCount)';
}


}

/// @nodoc
abstract mixin class _$UserViewsResponseCopyWith<$Res> implements $UserViewsResponseCopyWith<$Res> {
  factory _$UserViewsResponseCopyWith(_UserViewsResponse value, $Res Function(_UserViewsResponse) _then) = __$UserViewsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Items') List<UserView> items,@JsonKey(name: 'TotalRecordCount') int totalRecordCount
});




}
/// @nodoc
class __$UserViewsResponseCopyWithImpl<$Res>
    implements _$UserViewsResponseCopyWith<$Res> {
  __$UserViewsResponseCopyWithImpl(this._self, this._then);

  final _UserViewsResponse _self;
  final $Res Function(_UserViewsResponse) _then;

/// Create a copy of UserViewsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalRecordCount = null,}) {
  return _then(_UserViewsResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<UserView>,totalRecordCount: null == totalRecordCount ? _self.totalRecordCount : totalRecordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MediaItem {

@JsonKey(name: 'Id') String get id;@JsonKey(name: 'Name') String get name;@JsonKey(name: 'Type') String get type;@JsonKey(name: 'ServerId') String? get serverId;@JsonKey(name: 'ProductionYear') int? get productionYear;@JsonKey(name: 'CommunityRating') double? get communityRating;@JsonKey(name: 'ImageTags') Map<String, String>? get imageTags;@JsonKey(name: 'BackdropImageTags') List<String>? get backdropImageTags;@JsonKey(name: 'Overview') String? get overview;@JsonKey(name: 'RunTimeTicks') int? get runTimeTicks;@JsonKey(name: 'OfficialRating') String? get officialRating;
/// Create a copy of MediaItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaItemCopyWith<MediaItem> get copyWith => _$MediaItemCopyWithImpl<MediaItem>(this as MediaItem, _$identity);

  /// Serializes this MediaItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.productionYear, productionYear) || other.productionYear == productionYear)&&(identical(other.communityRating, communityRating) || other.communityRating == communityRating)&&const DeepCollectionEquality().equals(other.imageTags, imageTags)&&const DeepCollectionEquality().equals(other.backdropImageTags, backdropImageTags)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.runTimeTicks, runTimeTicks) || other.runTimeTicks == runTimeTicks)&&(identical(other.officialRating, officialRating) || other.officialRating == officialRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,serverId,productionYear,communityRating,const DeepCollectionEquality().hash(imageTags),const DeepCollectionEquality().hash(backdropImageTags),overview,runTimeTicks,officialRating);

@override
String toString() {
  return 'MediaItem(id: $id, name: $name, type: $type, serverId: $serverId, productionYear: $productionYear, communityRating: $communityRating, imageTags: $imageTags, backdropImageTags: $backdropImageTags, overview: $overview, runTimeTicks: $runTimeTicks, officialRating: $officialRating)';
}


}

/// @nodoc
abstract mixin class $MediaItemCopyWith<$Res>  {
  factory $MediaItemCopyWith(MediaItem value, $Res Function(MediaItem) _then) = _$MediaItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'Type') String type,@JsonKey(name: 'ServerId') String? serverId,@JsonKey(name: 'ProductionYear') int? productionYear,@JsonKey(name: 'CommunityRating') double? communityRating,@JsonKey(name: 'ImageTags') Map<String, String>? imageTags,@JsonKey(name: 'BackdropImageTags') List<String>? backdropImageTags,@JsonKey(name: 'Overview') String? overview,@JsonKey(name: 'RunTimeTicks') int? runTimeTicks,@JsonKey(name: 'OfficialRating') String? officialRating
});




}
/// @nodoc
class _$MediaItemCopyWithImpl<$Res>
    implements $MediaItemCopyWith<$Res> {
  _$MediaItemCopyWithImpl(this._self, this._then);

  final MediaItem _self;
  final $Res Function(MediaItem) _then;

/// Create a copy of MediaItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? serverId = freezed,Object? productionYear = freezed,Object? communityRating = freezed,Object? imageTags = freezed,Object? backdropImageTags = freezed,Object? overview = freezed,Object? runTimeTicks = freezed,Object? officialRating = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,productionYear: freezed == productionYear ? _self.productionYear : productionYear // ignore: cast_nullable_to_non_nullable
as int?,communityRating: freezed == communityRating ? _self.communityRating : communityRating // ignore: cast_nullable_to_non_nullable
as double?,imageTags: freezed == imageTags ? _self.imageTags : imageTags // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,backdropImageTags: freezed == backdropImageTags ? _self.backdropImageTags : backdropImageTags // ignore: cast_nullable_to_non_nullable
as List<String>?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,runTimeTicks: freezed == runTimeTicks ? _self.runTimeTicks : runTimeTicks // ignore: cast_nullable_to_non_nullable
as int?,officialRating: freezed == officialRating ? _self.officialRating : officialRating // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaItem].
extension MediaItemPatterns on MediaItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaItem value)  $default,){
final _that = this;
switch (_that) {
case _MediaItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaItem value)?  $default,){
final _that = this;
switch (_that) {
case _MediaItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Type')  String type, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'ProductionYear')  int? productionYear, @JsonKey(name: 'CommunityRating')  double? communityRating, @JsonKey(name: 'ImageTags')  Map<String, String>? imageTags, @JsonKey(name: 'BackdropImageTags')  List<String>? backdropImageTags, @JsonKey(name: 'Overview')  String? overview, @JsonKey(name: 'RunTimeTicks')  int? runTimeTicks, @JsonKey(name: 'OfficialRating')  String? officialRating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaItem() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.serverId,_that.productionYear,_that.communityRating,_that.imageTags,_that.backdropImageTags,_that.overview,_that.runTimeTicks,_that.officialRating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Type')  String type, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'ProductionYear')  int? productionYear, @JsonKey(name: 'CommunityRating')  double? communityRating, @JsonKey(name: 'ImageTags')  Map<String, String>? imageTags, @JsonKey(name: 'BackdropImageTags')  List<String>? backdropImageTags, @JsonKey(name: 'Overview')  String? overview, @JsonKey(name: 'RunTimeTicks')  int? runTimeTicks, @JsonKey(name: 'OfficialRating')  String? officialRating)  $default,) {final _that = this;
switch (_that) {
case _MediaItem():
return $default(_that.id,_that.name,_that.type,_that.serverId,_that.productionYear,_that.communityRating,_that.imageTags,_that.backdropImageTags,_that.overview,_that.runTimeTicks,_that.officialRating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'Type')  String type, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'ProductionYear')  int? productionYear, @JsonKey(name: 'CommunityRating')  double? communityRating, @JsonKey(name: 'ImageTags')  Map<String, String>? imageTags, @JsonKey(name: 'BackdropImageTags')  List<String>? backdropImageTags, @JsonKey(name: 'Overview')  String? overview, @JsonKey(name: 'RunTimeTicks')  int? runTimeTicks, @JsonKey(name: 'OfficialRating')  String? officialRating)?  $default,) {final _that = this;
switch (_that) {
case _MediaItem() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.serverId,_that.productionYear,_that.communityRating,_that.imageTags,_that.backdropImageTags,_that.overview,_that.runTimeTicks,_that.officialRating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaItem implements MediaItem {
  const _MediaItem({@JsonKey(name: 'Id') required this.id, @JsonKey(name: 'Name') required this.name, @JsonKey(name: 'Type') required this.type, @JsonKey(name: 'ServerId') this.serverId, @JsonKey(name: 'ProductionYear') this.productionYear, @JsonKey(name: 'CommunityRating') this.communityRating, @JsonKey(name: 'ImageTags') final  Map<String, String>? imageTags, @JsonKey(name: 'BackdropImageTags') final  List<String>? backdropImageTags, @JsonKey(name: 'Overview') this.overview, @JsonKey(name: 'RunTimeTicks') this.runTimeTicks, @JsonKey(name: 'OfficialRating') this.officialRating}): _imageTags = imageTags,_backdropImageTags = backdropImageTags;
  factory _MediaItem.fromJson(Map<String, dynamic> json) => _$MediaItemFromJson(json);

@override@JsonKey(name: 'Id') final  String id;
@override@JsonKey(name: 'Name') final  String name;
@override@JsonKey(name: 'Type') final  String type;
@override@JsonKey(name: 'ServerId') final  String? serverId;
@override@JsonKey(name: 'ProductionYear') final  int? productionYear;
@override@JsonKey(name: 'CommunityRating') final  double? communityRating;
 final  Map<String, String>? _imageTags;
@override@JsonKey(name: 'ImageTags') Map<String, String>? get imageTags {
  final value = _imageTags;
  if (value == null) return null;
  if (_imageTags is EqualUnmodifiableMapView) return _imageTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<String>? _backdropImageTags;
@override@JsonKey(name: 'BackdropImageTags') List<String>? get backdropImageTags {
  final value = _backdropImageTags;
  if (value == null) return null;
  if (_backdropImageTags is EqualUnmodifiableListView) return _backdropImageTags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'Overview') final  String? overview;
@override@JsonKey(name: 'RunTimeTicks') final  int? runTimeTicks;
@override@JsonKey(name: 'OfficialRating') final  String? officialRating;

/// Create a copy of MediaItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaItemCopyWith<_MediaItem> get copyWith => __$MediaItemCopyWithImpl<_MediaItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.productionYear, productionYear) || other.productionYear == productionYear)&&(identical(other.communityRating, communityRating) || other.communityRating == communityRating)&&const DeepCollectionEquality().equals(other._imageTags, _imageTags)&&const DeepCollectionEquality().equals(other._backdropImageTags, _backdropImageTags)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.runTimeTicks, runTimeTicks) || other.runTimeTicks == runTimeTicks)&&(identical(other.officialRating, officialRating) || other.officialRating == officialRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,serverId,productionYear,communityRating,const DeepCollectionEquality().hash(_imageTags),const DeepCollectionEquality().hash(_backdropImageTags),overview,runTimeTicks,officialRating);

@override
String toString() {
  return 'MediaItem(id: $id, name: $name, type: $type, serverId: $serverId, productionYear: $productionYear, communityRating: $communityRating, imageTags: $imageTags, backdropImageTags: $backdropImageTags, overview: $overview, runTimeTicks: $runTimeTicks, officialRating: $officialRating)';
}


}

/// @nodoc
abstract mixin class _$MediaItemCopyWith<$Res> implements $MediaItemCopyWith<$Res> {
  factory _$MediaItemCopyWith(_MediaItem value, $Res Function(_MediaItem) _then) = __$MediaItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'Type') String type,@JsonKey(name: 'ServerId') String? serverId,@JsonKey(name: 'ProductionYear') int? productionYear,@JsonKey(name: 'CommunityRating') double? communityRating,@JsonKey(name: 'ImageTags') Map<String, String>? imageTags,@JsonKey(name: 'BackdropImageTags') List<String>? backdropImageTags,@JsonKey(name: 'Overview') String? overview,@JsonKey(name: 'RunTimeTicks') int? runTimeTicks,@JsonKey(name: 'OfficialRating') String? officialRating
});




}
/// @nodoc
class __$MediaItemCopyWithImpl<$Res>
    implements _$MediaItemCopyWith<$Res> {
  __$MediaItemCopyWithImpl(this._self, this._then);

  final _MediaItem _self;
  final $Res Function(_MediaItem) _then;

/// Create a copy of MediaItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? serverId = freezed,Object? productionYear = freezed,Object? communityRating = freezed,Object? imageTags = freezed,Object? backdropImageTags = freezed,Object? overview = freezed,Object? runTimeTicks = freezed,Object? officialRating = freezed,}) {
  return _then(_MediaItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,productionYear: freezed == productionYear ? _self.productionYear : productionYear // ignore: cast_nullable_to_non_nullable
as int?,communityRating: freezed == communityRating ? _self.communityRating : communityRating // ignore: cast_nullable_to_non_nullable
as double?,imageTags: freezed == imageTags ? _self._imageTags : imageTags // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,backdropImageTags: freezed == backdropImageTags ? _self._backdropImageTags : backdropImageTags // ignore: cast_nullable_to_non_nullable
as List<String>?,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,runTimeTicks: freezed == runTimeTicks ? _self.runTimeTicks : runTimeTicks // ignore: cast_nullable_to_non_nullable
as int?,officialRating: freezed == officialRating ? _self.officialRating : officialRating // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MediaItemsResponse {

@JsonKey(name: 'Items') List<MediaItem> get items;@JsonKey(name: 'TotalRecordCount') int get totalRecordCount;@JsonKey(name: 'StartIndex') int get startIndex;
/// Create a copy of MediaItemsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaItemsResponseCopyWith<MediaItemsResponse> get copyWith => _$MediaItemsResponseCopyWithImpl<MediaItemsResponse>(this as MediaItemsResponse, _$identity);

  /// Serializes this MediaItemsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaItemsResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalRecordCount, totalRecordCount) || other.totalRecordCount == totalRecordCount)&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalRecordCount,startIndex);

@override
String toString() {
  return 'MediaItemsResponse(items: $items, totalRecordCount: $totalRecordCount, startIndex: $startIndex)';
}


}

/// @nodoc
abstract mixin class $MediaItemsResponseCopyWith<$Res>  {
  factory $MediaItemsResponseCopyWith(MediaItemsResponse value, $Res Function(MediaItemsResponse) _then) = _$MediaItemsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Items') List<MediaItem> items,@JsonKey(name: 'TotalRecordCount') int totalRecordCount,@JsonKey(name: 'StartIndex') int startIndex
});




}
/// @nodoc
class _$MediaItemsResponseCopyWithImpl<$Res>
    implements $MediaItemsResponseCopyWith<$Res> {
  _$MediaItemsResponseCopyWithImpl(this._self, this._then);

  final MediaItemsResponse _self;
  final $Res Function(MediaItemsResponse) _then;

/// Create a copy of MediaItemsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalRecordCount = null,Object? startIndex = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MediaItem>,totalRecordCount: null == totalRecordCount ? _self.totalRecordCount : totalRecordCount // ignore: cast_nullable_to_non_nullable
as int,startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaItemsResponse].
extension MediaItemsResponsePatterns on MediaItemsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaItemsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaItemsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaItemsResponse value)  $default,){
final _that = this;
switch (_that) {
case _MediaItemsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaItemsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _MediaItemsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Items')  List<MediaItem> items, @JsonKey(name: 'TotalRecordCount')  int totalRecordCount, @JsonKey(name: 'StartIndex')  int startIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaItemsResponse() when $default != null:
return $default(_that.items,_that.totalRecordCount,_that.startIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Items')  List<MediaItem> items, @JsonKey(name: 'TotalRecordCount')  int totalRecordCount, @JsonKey(name: 'StartIndex')  int startIndex)  $default,) {final _that = this;
switch (_that) {
case _MediaItemsResponse():
return $default(_that.items,_that.totalRecordCount,_that.startIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Items')  List<MediaItem> items, @JsonKey(name: 'TotalRecordCount')  int totalRecordCount, @JsonKey(name: 'StartIndex')  int startIndex)?  $default,) {final _that = this;
switch (_that) {
case _MediaItemsResponse() when $default != null:
return $default(_that.items,_that.totalRecordCount,_that.startIndex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaItemsResponse implements MediaItemsResponse {
  const _MediaItemsResponse({@JsonKey(name: 'Items') required final  List<MediaItem> items, @JsonKey(name: 'TotalRecordCount') required this.totalRecordCount, @JsonKey(name: 'StartIndex') required this.startIndex}): _items = items;
  factory _MediaItemsResponse.fromJson(Map<String, dynamic> json) => _$MediaItemsResponseFromJson(json);

 final  List<MediaItem> _items;
@override@JsonKey(name: 'Items') List<MediaItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey(name: 'TotalRecordCount') final  int totalRecordCount;
@override@JsonKey(name: 'StartIndex') final  int startIndex;

/// Create a copy of MediaItemsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaItemsResponseCopyWith<_MediaItemsResponse> get copyWith => __$MediaItemsResponseCopyWithImpl<_MediaItemsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaItemsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaItemsResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalRecordCount, totalRecordCount) || other.totalRecordCount == totalRecordCount)&&(identical(other.startIndex, startIndex) || other.startIndex == startIndex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalRecordCount,startIndex);

@override
String toString() {
  return 'MediaItemsResponse(items: $items, totalRecordCount: $totalRecordCount, startIndex: $startIndex)';
}


}

/// @nodoc
abstract mixin class _$MediaItemsResponseCopyWith<$Res> implements $MediaItemsResponseCopyWith<$Res> {
  factory _$MediaItemsResponseCopyWith(_MediaItemsResponse value, $Res Function(_MediaItemsResponse) _then) = __$MediaItemsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Items') List<MediaItem> items,@JsonKey(name: 'TotalRecordCount') int totalRecordCount,@JsonKey(name: 'StartIndex') int startIndex
});




}
/// @nodoc
class __$MediaItemsResponseCopyWithImpl<$Res>
    implements _$MediaItemsResponseCopyWith<$Res> {
  __$MediaItemsResponseCopyWithImpl(this._self, this._then);

  final _MediaItemsResponse _self;
  final $Res Function(_MediaItemsResponse) _then;

/// Create a copy of MediaItemsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalRecordCount = null,Object? startIndex = null,}) {
  return _then(_MediaItemsResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MediaItem>,totalRecordCount: null == totalRecordCount ? _self.totalRecordCount : totalRecordCount // ignore: cast_nullable_to_non_nullable
as int,startIndex: null == startIndex ? _self.startIndex : startIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
