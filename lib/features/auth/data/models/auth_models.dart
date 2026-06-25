import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

// ─── Request ──────────────────────────────────────────────────────────────────

@freezed
abstract class AuthenticateRequest with _$AuthenticateRequest {
  const factory AuthenticateRequest({
    @JsonKey(name: 'Username') required String username,
    @JsonKey(name: 'Pw') required String password,
  }) = _AuthenticateRequest;

  factory AuthenticateRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateRequestFromJson(json);
}

// ─── Response ─────────────────────────────────────────────────────────────────

@freezed
abstract class AuthenticateResponse with _$AuthenticateResponse {
  const factory AuthenticateResponse({
    @JsonKey(name: 'AccessToken') required String accessToken,
    @JsonKey(name: 'ServerId') required String serverId,
    @JsonKey(name: 'User') required AuthUser user,
  }) = _AuthenticateResponse;

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateResponseFromJson(json);
}

@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    @JsonKey(name: 'Id') required String id,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'ServerId') String? serverId,
    @JsonKey(name: 'HasPassword') @Default(false) bool hasPassword,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

// ─── Auth State ───────────────────────────────────────────────────────────────

@freezed
sealed class AuthState with _$AuthState {
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
