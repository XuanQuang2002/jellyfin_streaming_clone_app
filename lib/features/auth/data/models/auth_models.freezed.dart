// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticateRequest {

@JsonKey(name: 'Username') String get username;@JsonKey(name: 'Pw') String get password;
/// Create a copy of AuthenticateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticateRequestCopyWith<AuthenticateRequest> get copyWith => _$AuthenticateRequestCopyWithImpl<AuthenticateRequest>(this as AuthenticateRequest, _$identity);

  /// Serializes this AuthenticateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticateRequest&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,password);

@override
String toString() {
  return 'AuthenticateRequest(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthenticateRequestCopyWith<$Res>  {
  factory $AuthenticateRequestCopyWith(AuthenticateRequest value, $Res Function(AuthenticateRequest) _then) = _$AuthenticateRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Username') String username,@JsonKey(name: 'Pw') String password
});




}
/// @nodoc
class _$AuthenticateRequestCopyWithImpl<$Res>
    implements $AuthenticateRequestCopyWith<$Res> {
  _$AuthenticateRequestCopyWithImpl(this._self, this._then);

  final AuthenticateRequest _self;
  final $Res Function(AuthenticateRequest) _then;

/// Create a copy of AuthenticateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? password = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthenticateRequest].
extension AuthenticateRequestPatterns on AuthenticateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthenticateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthenticateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthenticateRequest value)  $default,){
final _that = this;
switch (_that) {
case _AuthenticateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthenticateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _AuthenticateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Username')  String username, @JsonKey(name: 'Pw')  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthenticateRequest() when $default != null:
return $default(_that.username,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Username')  String username, @JsonKey(name: 'Pw')  String password)  $default,) {final _that = this;
switch (_that) {
case _AuthenticateRequest():
return $default(_that.username,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Username')  String username, @JsonKey(name: 'Pw')  String password)?  $default,) {final _that = this;
switch (_that) {
case _AuthenticateRequest() when $default != null:
return $default(_that.username,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthenticateRequest implements AuthenticateRequest {
  const _AuthenticateRequest({@JsonKey(name: 'Username') required this.username, @JsonKey(name: 'Pw') required this.password});
  factory _AuthenticateRequest.fromJson(Map<String, dynamic> json) => _$AuthenticateRequestFromJson(json);

@override@JsonKey(name: 'Username') final  String username;
@override@JsonKey(name: 'Pw') final  String password;

/// Create a copy of AuthenticateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticateRequestCopyWith<_AuthenticateRequest> get copyWith => __$AuthenticateRequestCopyWithImpl<_AuthenticateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthenticateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticateRequest&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,password);

@override
String toString() {
  return 'AuthenticateRequest(username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class _$AuthenticateRequestCopyWith<$Res> implements $AuthenticateRequestCopyWith<$Res> {
  factory _$AuthenticateRequestCopyWith(_AuthenticateRequest value, $Res Function(_AuthenticateRequest) _then) = __$AuthenticateRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Username') String username,@JsonKey(name: 'Pw') String password
});




}
/// @nodoc
class __$AuthenticateRequestCopyWithImpl<$Res>
    implements _$AuthenticateRequestCopyWith<$Res> {
  __$AuthenticateRequestCopyWithImpl(this._self, this._then);

  final _AuthenticateRequest _self;
  final $Res Function(_AuthenticateRequest) _then;

/// Create a copy of AuthenticateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,}) {
  return _then(_AuthenticateRequest(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthenticateResponse {

@JsonKey(name: 'AccessToken') String get accessToken;@JsonKey(name: 'ServerId') String get serverId;@JsonKey(name: 'User') AuthUser get user;
/// Create a copy of AuthenticateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticateResponseCopyWith<AuthenticateResponse> get copyWith => _$AuthenticateResponseCopyWithImpl<AuthenticateResponse>(this as AuthenticateResponse, _$identity);

  /// Serializes this AuthenticateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticateResponse&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,serverId,user);

@override
String toString() {
  return 'AuthenticateResponse(accessToken: $accessToken, serverId: $serverId, user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthenticateResponseCopyWith<$Res>  {
  factory $AuthenticateResponseCopyWith(AuthenticateResponse value, $Res Function(AuthenticateResponse) _then) = _$AuthenticateResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'AccessToken') String accessToken,@JsonKey(name: 'ServerId') String serverId,@JsonKey(name: 'User') AuthUser user
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthenticateResponseCopyWithImpl<$Res>
    implements $AuthenticateResponseCopyWith<$Res> {
  _$AuthenticateResponseCopyWithImpl(this._self, this._then);

  final AuthenticateResponse _self;
  final $Res Function(AuthenticateResponse) _then;

/// Create a copy of AuthenticateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? serverId = null,Object? user = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}
/// Create a copy of AuthenticateResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthenticateResponse].
extension AuthenticateResponsePatterns on AuthenticateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthenticateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthenticateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthenticateResponse value)  $default,){
final _that = this;
switch (_that) {
case _AuthenticateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthenticateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AuthenticateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'AccessToken')  String accessToken, @JsonKey(name: 'ServerId')  String serverId, @JsonKey(name: 'User')  AuthUser user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthenticateResponse() when $default != null:
return $default(_that.accessToken,_that.serverId,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'AccessToken')  String accessToken, @JsonKey(name: 'ServerId')  String serverId, @JsonKey(name: 'User')  AuthUser user)  $default,) {final _that = this;
switch (_that) {
case _AuthenticateResponse():
return $default(_that.accessToken,_that.serverId,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'AccessToken')  String accessToken, @JsonKey(name: 'ServerId')  String serverId, @JsonKey(name: 'User')  AuthUser user)?  $default,) {final _that = this;
switch (_that) {
case _AuthenticateResponse() when $default != null:
return $default(_that.accessToken,_that.serverId,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthenticateResponse implements AuthenticateResponse {
  const _AuthenticateResponse({@JsonKey(name: 'AccessToken') required this.accessToken, @JsonKey(name: 'ServerId') required this.serverId, @JsonKey(name: 'User') required this.user});
  factory _AuthenticateResponse.fromJson(Map<String, dynamic> json) => _$AuthenticateResponseFromJson(json);

@override@JsonKey(name: 'AccessToken') final  String accessToken;
@override@JsonKey(name: 'ServerId') final  String serverId;
@override@JsonKey(name: 'User') final  AuthUser user;

/// Create a copy of AuthenticateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthenticateResponseCopyWith<_AuthenticateResponse> get copyWith => __$AuthenticateResponseCopyWithImpl<_AuthenticateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthenticateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthenticateResponse&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,serverId,user);

@override
String toString() {
  return 'AuthenticateResponse(accessToken: $accessToken, serverId: $serverId, user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthenticateResponseCopyWith<$Res> implements $AuthenticateResponseCopyWith<$Res> {
  factory _$AuthenticateResponseCopyWith(_AuthenticateResponse value, $Res Function(_AuthenticateResponse) _then) = __$AuthenticateResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'AccessToken') String accessToken,@JsonKey(name: 'ServerId') String serverId,@JsonKey(name: 'User') AuthUser user
});


@override $AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class __$AuthenticateResponseCopyWithImpl<$Res>
    implements _$AuthenticateResponseCopyWith<$Res> {
  __$AuthenticateResponseCopyWithImpl(this._self, this._then);

  final _AuthenticateResponse _self;
  final $Res Function(_AuthenticateResponse) _then;

/// Create a copy of AuthenticateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? serverId = null,Object? user = null,}) {
  return _then(_AuthenticateResponse(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,serverId: null == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}

/// Create a copy of AuthenticateResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$AuthUser {

@JsonKey(name: 'Id') String get id;@JsonKey(name: 'Name') String get name;@JsonKey(name: 'ServerId') String? get serverId;@JsonKey(name: 'HasPassword') bool get hasPassword;
/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUserCopyWith<AuthUser> get copyWith => _$AuthUserCopyWithImpl<AuthUser>(this as AuthUser, _$identity);

  /// Serializes this AuthUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.hasPassword, hasPassword) || other.hasPassword == hasPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,serverId,hasPassword);

@override
String toString() {
  return 'AuthUser(id: $id, name: $name, serverId: $serverId, hasPassword: $hasPassword)';
}


}

/// @nodoc
abstract mixin class $AuthUserCopyWith<$Res>  {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) _then) = _$AuthUserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'ServerId') String? serverId,@JsonKey(name: 'HasPassword') bool hasPassword
});




}
/// @nodoc
class _$AuthUserCopyWithImpl<$Res>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._self, this._then);

  final AuthUser _self;
  final $Res Function(AuthUser) _then;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? serverId = freezed,Object? hasPassword = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,hasPassword: null == hasPassword ? _self.hasPassword : hasPassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthUser].
extension AuthUserPatterns on AuthUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthUser value)  $default,){
final _that = this;
switch (_that) {
case _AuthUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthUser value)?  $default,){
final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'HasPassword')  bool hasPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
return $default(_that.id,_that.name,_that.serverId,_that.hasPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'HasPassword')  bool hasPassword)  $default,) {final _that = this;
switch (_that) {
case _AuthUser():
return $default(_that.id,_that.name,_that.serverId,_that.hasPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'Id')  String id, @JsonKey(name: 'Name')  String name, @JsonKey(name: 'ServerId')  String? serverId, @JsonKey(name: 'HasPassword')  bool hasPassword)?  $default,) {final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
return $default(_that.id,_that.name,_that.serverId,_that.hasPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthUser implements AuthUser {
  const _AuthUser({@JsonKey(name: 'Id') required this.id, @JsonKey(name: 'Name') required this.name, @JsonKey(name: 'ServerId') this.serverId, @JsonKey(name: 'HasPassword') this.hasPassword = false});
  factory _AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);

@override@JsonKey(name: 'Id') final  String id;
@override@JsonKey(name: 'Name') final  String name;
@override@JsonKey(name: 'ServerId') final  String? serverId;
@override@JsonKey(name: 'HasPassword') final  bool hasPassword;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthUserCopyWith<_AuthUser> get copyWith => __$AuthUserCopyWithImpl<_AuthUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthUser&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.serverId, serverId) || other.serverId == serverId)&&(identical(other.hasPassword, hasPassword) || other.hasPassword == hasPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,serverId,hasPassword);

@override
String toString() {
  return 'AuthUser(id: $id, name: $name, serverId: $serverId, hasPassword: $hasPassword)';
}


}

/// @nodoc
abstract mixin class _$AuthUserCopyWith<$Res> implements $AuthUserCopyWith<$Res> {
  factory _$AuthUserCopyWith(_AuthUser value, $Res Function(_AuthUser) _then) = __$AuthUserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'Id') String id,@JsonKey(name: 'Name') String name,@JsonKey(name: 'ServerId') String? serverId,@JsonKey(name: 'HasPassword') bool hasPassword
});




}
/// @nodoc
class __$AuthUserCopyWithImpl<$Res>
    implements _$AuthUserCopyWith<$Res> {
  __$AuthUserCopyWithImpl(this._self, this._then);

  final _AuthUser _self;
  final $Res Function(_AuthUser) _then;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? serverId = freezed,Object? hasPassword = null,}) {
  return _then(_AuthUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,serverId: freezed == serverId ? _self.serverId : serverId // ignore: cast_nullable_to_non_nullable
as String?,hasPassword: null == hasPassword ? _self.hasPassword : hasPassword // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthStateUnauthenticated value)?  unauthenticated,TResult Function( AuthStateAuthenticated value)?  authenticated,TResult Function( AuthStateLoading value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that);case AuthStateLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthStateUnauthenticated value)  unauthenticated,required TResult Function( AuthStateAuthenticated value)  authenticated,required TResult Function( AuthStateLoading value)  loading,}){
final _that = this;
switch (_that) {
case AuthStateUnauthenticated():
return unauthenticated(_that);case AuthStateAuthenticated():
return authenticated(_that);case AuthStateLoading():
return loading(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthStateUnauthenticated value)?  unauthenticated,TResult? Function( AuthStateAuthenticated value)?  authenticated,TResult? Function( AuthStateLoading value)?  loading,}){
final _that = this;
switch (_that) {
case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that);case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that);case AuthStateLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unauthenticated,TResult Function( String serverUrl,  String accessToken,  String userId,  String username,  String deviceId)?  authenticated,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that.serverUrl,_that.accessToken,_that.userId,_that.username,_that.deviceId);case AuthStateLoading() when loading != null:
return loading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unauthenticated,required TResult Function( String serverUrl,  String accessToken,  String userId,  String username,  String deviceId)  authenticated,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case AuthStateUnauthenticated():
return unauthenticated();case AuthStateAuthenticated():
return authenticated(_that.serverUrl,_that.accessToken,_that.userId,_that.username,_that.deviceId);case AuthStateLoading():
return loading();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unauthenticated,TResult? Function( String serverUrl,  String accessToken,  String userId,  String username,  String deviceId)?  authenticated,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case AuthStateUnauthenticated() when unauthenticated != null:
return unauthenticated();case AuthStateAuthenticated() when authenticated != null:
return authenticated(_that.serverUrl,_that.accessToken,_that.userId,_that.username,_that.deviceId);case AuthStateLoading() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class AuthStateUnauthenticated implements AuthState {
  const AuthStateUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unauthenticated()';
}


}




/// @nodoc


class AuthStateAuthenticated implements AuthState {
  const AuthStateAuthenticated({required this.serverUrl, required this.accessToken, required this.userId, required this.username, required this.deviceId});
  

 final  String serverUrl;
 final  String accessToken;
 final  String userId;
 final  String username;
 final  String deviceId;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateAuthenticatedCopyWith<AuthStateAuthenticated> get copyWith => _$AuthStateAuthenticatedCopyWithImpl<AuthStateAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateAuthenticated&&(identical(other.serverUrl, serverUrl) || other.serverUrl == serverUrl)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}


@override
int get hashCode => Object.hash(runtimeType,serverUrl,accessToken,userId,username,deviceId);

@override
String toString() {
  return 'AuthState.authenticated(serverUrl: $serverUrl, accessToken: $accessToken, userId: $userId, username: $username, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $AuthStateAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthStateAuthenticatedCopyWith(AuthStateAuthenticated value, $Res Function(AuthStateAuthenticated) _then) = _$AuthStateAuthenticatedCopyWithImpl;
@useResult
$Res call({
 String serverUrl, String accessToken, String userId, String username, String deviceId
});




}
/// @nodoc
class _$AuthStateAuthenticatedCopyWithImpl<$Res>
    implements $AuthStateAuthenticatedCopyWith<$Res> {
  _$AuthStateAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthStateAuthenticated _self;
  final $Res Function(AuthStateAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serverUrl = null,Object? accessToken = null,Object? userId = null,Object? username = null,Object? deviceId = null,}) {
  return _then(AuthStateAuthenticated(
serverUrl: null == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthStateLoading implements AuthState {
  const AuthStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




// dart format on
