import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/network/app_exception.dart';
import '../../../../core/network/jellyfin_constants.dart';
import '../../../../core/storage/hive_storage.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_models.dart';

class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  // ─── Authenticate ─────────────────────────────────────────────────────────

  /// Authenticates with the Jellyfin server.
  ///
  /// 1. Validates the server URL is reachable.
  /// 2. Sends credentials to `/Users/AuthenticateByName`.
  /// 3. Persists the token securely and metadata to Hive.
  Future<AuthenticateResponse> authenticate({
    required String serverUrl,
    required String username,
    required String password,
  }) async {
    // Normalise server URL — strip trailing slash
    final normalised = serverUrl.trimRight().replaceAll(RegExp(r'/+$'), '');

    // Update Dio base URL before the call
    DioClient.updateBaseUrl(normalised);

    // Generate or reuse a stable device ID
    final deviceId = await _getOrCreateDeviceId();

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        JellyfinConstants.authByName,
        data: AuthenticateRequest(
          username: username,
          password: password,
        ).toJson(),
      );

      final authResponse = AuthenticateResponse.fromJson(response.data!);

      // Persist token securely
      await SecureStorage.saveAccessToken(authResponse.accessToken);
      await SecureStorage.saveDeviceId(deviceId);

      // Persist non-sensitive data to Hive (survives cold starts)
      await HiveStorage.saveAuthData(
        serverUrl: normalised,
        userId: authResponse.user.id,
        username: authResponse.user.name,
        deviceId: deviceId,
      );

      return authResponse;
    } on DioException catch (e) {
      // Re-throw the typed AppException already set by ErrorInterceptor
      throw e.error is AppException
          ? e.error as AppException
          : const UnknownException();
    }
  }

  // ─── Restore Session ──────────────────────────────────────────────────────

  /// Returns a populated [AuthenticateResponse]-equivalent state if a valid
  /// session exists, otherwise returns null (caller shows login screen).
  Future<AuthStateAuthenticated?> restoreSession() async {
    final token = await SecureStorage.getAccessToken();
    final serverUrl = HiveStorage.serverUrl;
    final userId = HiveStorage.userId;
    final username = HiveStorage.username;
    final deviceId = await SecureStorage.getDeviceId();

    if (token == null ||
        serverUrl == null ||
        userId == null ||
        username == null) {
      return null;
    }

    // Restore Dio base URL
    DioClient.updateBaseUrl(serverUrl);

    return AuthStateAuthenticated(
      serverUrl: serverUrl,
      accessToken: token,
      userId: userId,
      username: username,
      deviceId: deviceId ?? 'unknown',
    );
  }

  // ─── Logout ───────────────────────────────────────────────────────────────

  Future<void> logout() async {
    await SecureStorage.clearAll();
    await HiveStorage.clearAuthData();
    DioClient.reset();
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Future<String> _getOrCreateDeviceId() async {
    final existing = await SecureStorage.getDeviceId();
    if (existing != null) return existing;

    final id = const Uuid().v4();
    await SecureStorage.saveDeviceId(id);
    return id;
  }

  String get deviceName {
    if (Platform.isIOS) return 'iPhone';
    if (Platform.isAndroid) return 'Android';
    return 'Flutter Device';
  }
}
