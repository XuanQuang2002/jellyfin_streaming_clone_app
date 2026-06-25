import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';
import '../storage/hive_storage.dart';
import 'jellyfin_constants.dart';

/// Automatically injects the `X-Emby-Authorization` header on every request.
///
/// Reads the current token from [SecureStorage] and device info from [HiveStorage].
/// If no token is stored the header is sent without the Token field (for
/// unauthenticated endpoints like `/Users/AuthenticateByName`).
class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getAccessToken();
    final deviceId = await SecureStorage.getDeviceId() ?? 'unknown-device';
    final deviceName = HiveStorage.username ?? 'Flutter Device';

    options.headers['X-Emby-Authorization'] = JellyfinConstants.buildAuthHeader(
      deviceName: deviceName,
      deviceId: deviceId,
      token: token,
    );

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    handler.next(options);
  }
}
