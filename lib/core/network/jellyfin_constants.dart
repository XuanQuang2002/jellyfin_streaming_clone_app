/// Jellyfin API constants and header helpers.
class JellyfinConstants {
  JellyfinConstants._();

  static const appName = 'JellyfinStreamingApp';
  static const appVersion = '1.0.0';

  // API paths
  static const authByName = '/Users/AuthenticateByName';
  static const publicUsers = '/Users/Public';
  static const userViews = '/Users/{userId}/Views';
  static const userItems = '/Users/{userId}/Items';
  static const itemInfo = '/Users/{userId}/Items/{itemId}';
  static const sessions = '/Sessions';
  static const sessionPlaying = '/Sessions/Playing';
  static const sessionProgress = '/Sessions/Playing/Progress';
  static const sessionStopped = '/Sessions/Playing/Stopped';
  static const systemInfo = '/System/Info/Public';

  /// Builds the required Jellyfin `X-Emby-Authorization` header value.
  ///
  /// When [token] is null (unauthenticated), the Token field is omitted.
  static String buildAuthHeader({
    required String deviceName,
    required String deviceId,
    String? token,
  }) {
    final parts = [
      'MediaBrowser Client="$appName"',
      'Device="$deviceName"',
      'DeviceId="$deviceId"',
      'Version="$appVersion"',
      if (token != null) 'Token="$token"',
    ];
    return parts.join(', ');
  }
}
