import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/hive_storage.dart';
import 'auth_interceptor.dart';
import 'error_interceptor.dart';
import 'logging_interceptor.dart';

/// Creates and configures the [Dio] instance used throughout the app.
///
/// The base URL is read from [HiveStorage] so it is set after the user
/// saves their server address. Call [DioClient.updateBaseUrl] after login.
class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final serverUrl = HiveStorage.serverUrl ?? '';

    final dio = Dio(
      BaseOptions(
        baseUrl: serverUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(), // 1st — inject auth header
      ErrorInterceptor(), // 2nd — map errors before they bubble up
      LoggingInterceptor(), // 3rd — log after other interceptors run
    ]);

    return dio;
  }

  /// Call this after the user saves a new server URL or after login.
  static void updateBaseUrl(String serverUrl) {
    instance.options.baseUrl = serverUrl;
  }

  /// Completely recreate the Dio instance (e.g. after logout).
  static void reset() {
    _instance = null;
  }
}

// ─── Riverpod Provider ────────────────────────────────────────────────────────

/// Provides the configured [Dio] instance to the rest of the app.
final dioProvider = Provider<Dio>((ref) {
  return DioClient.instance;
});
