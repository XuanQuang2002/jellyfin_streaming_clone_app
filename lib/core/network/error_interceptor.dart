import 'package:dio/dio.dart';

import 'app_exception.dart';

/// Catches Dio errors and re-throws them as typed [AppException]s so every
/// repository only needs to catch `AppException` instead of raw `DioException`.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = _mapToAppException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        message: appException.message,
      ),
    );
  }

  AppException _mapToAppException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkException(
          'Connection timed out. Check your server address.',
        );

      case DioExceptionType.connectionError:
        final url = err.requestOptions.baseUrl;
        return ServerUnreachableException(url);

      case DioExceptionType.badResponse:
        return _mapStatusCode(err.response?.statusCode, err);

      case DioExceptionType.cancel:
        return const UnknownException('Request was cancelled.');

      default:
        return const NetworkException();
    }
  }

  AppException _mapStatusCode(int? statusCode, DioException err) {
    return switch (statusCode) {
      null => const UnknownException(),
      400 => const UnknownException('Bad request. Check your input.'),
      401 => const UnauthorizedException(),
      403 => const UnauthorizedException('Access denied.'),
      404 => const NotFoundException(),
      >= 500 => const ServerException(),
      _ => const UnknownException(),
    };
  }
}
