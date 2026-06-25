import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

// ─── Request ──────────────────────────────────────────────────────────────────

@freezed
class AuthenticateRequest with _$AuthenticateRequest {
  const factory AuthenticateRequest({
    @JsonKey(name: 'Username') required String username,
    @JsonKey(name: 'Pw') required String password,
  }) = _AuthenticateRequest;

  factory AuthenticateRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateRequestFromJson(json);

  @override
  // TODO: implement password
  String get password => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement username
  String get username => throw UnimplementedError();
}

// ─── Response ─────────────────────────────────────────────────────────────────

@freezed
class AuthenticateResponse with _$AuthenticateResponse {
  const factory AuthenticateResponse({
    @JsonKey(name: 'AccessToken') required String accessToken,
    @JsonKey(name: 'ServerId') required String serverId,
    @JsonKey(name: 'User') required AuthUser user,
  }) = _AuthenticateResponse;

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateResponseFromJson(json);

  @override
  // TODO: implement accessToken
  String get accessToken => throw UnimplementedError();

  @override
  // TODO: implement serverId
  String get serverId => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  AuthUser get user => throw UnimplementedError();
}

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'ServerId') String? serverId,
    @JsonKey(name: 'HasPassword') @Default(false) bool hasPassword,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  @override
  // TODO: implement hasPassword
  bool get hasPassword => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement serverId
  String? get serverId => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

// ─── Auth State ───────────────────────────────────────────────────────────────

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;

  const factory AuthState.authenticated({
    required String serverUrl,
    required String accessToken,
    required String userId,
    required String username,
    required String deviceId,
  }) = AuthStateAuthenticated;

  const factory AuthState.loading() = AuthStateLoading;
}
