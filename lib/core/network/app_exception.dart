/// Base exception for all app-level errors.
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Server returned a 401 — token expired or invalid credentials.
class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Invalid credentials. Please log in again.',
  ]);
}

/// Server returned a 404.
class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'The requested resource was not found.',
  ]);
}

/// Server returned 5xx or the host is unreachable.
class ServerException extends AppException {
  const ServerException([
    super.message = 'Server error. Please try again later.',
  ]);
}

/// No internet / connection refused / timeout.
class NetworkException extends AppException {
  const NetworkException([
    super.message = 'No internet connection. Check your network settings.',
  ]);
}

/// The Jellyfin server URL could not be reached.
class ServerUnreachableException extends AppException {
  const ServerUnreachableException(String serverUrl)
    : super('Cannot reach server at $serverUrl. Check the URL and try again.');
}

/// Generic / catch-all.
class UnknownException extends AppException {
  const UnknownException([super.message = 'An unexpected error occurred.']);
}
