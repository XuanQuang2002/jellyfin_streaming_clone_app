import 'package:hive_ce_flutter/hive_ce_flutter.dart';

/// Box names — use these constants everywhere instead of raw strings
class HiveBoxes {
  HiveBoxes._();

  static const auth = 'auth_box';
  static const mediaCache = 'media_cache_box';
  static const settings = 'settings_box';
}

/// Keys used inside Hive boxes
class HiveKeys {
  HiveKeys._();

  // Auth box
  static const serverUrl = 'server_url';
  static const userId = 'user_id';
  static const username = 'username';
  static const accessToken = 'access_token';
  static const deviceId = 'device_id';

  // Settings box
  static const preferredQuality = 'preferred_quality';
  static const subtitlesEnabled = 'subtitles_enabled';
  static const subtitleLanguage = 'subtitle_language';
  static const autoPlay = 'auto_play';
}

class HiveStorage {
  HiveStorage._();

  /// Register all Hive type adapters here.
  /// Add generated adapters as features are built.
  static Future<void> registerAdapters() async {
    // Example — add adapters as you generate them:
    // Hive.registerAdapter(MediaItemAdapter());
  }

  /// Open all Hive boxes the app needs.
  static Future<void> openBoxes() async {
    await Future.wait([
      Hive.openBox<dynamic>(HiveBoxes.auth),
      Hive.openBox<dynamic>(HiveBoxes.mediaCache),
      Hive.openBox<dynamic>(HiveBoxes.settings),
    ]);
  }

  // ─── Convenience getters ────────────────────────────────────────────────

  static Box<dynamic> get authBox => Hive.box(HiveBoxes.auth);
  static Box<dynamic> get mediaCacheBox => Hive.box(HiveBoxes.mediaCache);
  static Box<dynamic> get settingsBox => Hive.box(HiveBoxes.settings);

  // ─── Auth helpers ───────────────────────────────────────────────────────

  static String? get serverUrl => authBox.get(HiveKeys.serverUrl) as String?;
  static String? get userId => authBox.get(HiveKeys.userId) as String?;
  static String? get username => authBox.get(HiveKeys.username) as String?;
  static String? get deviceId => authBox.get(HiveKeys.deviceId) as String?;

  static Future<void> saveAuthData({
    required String serverUrl,
    required String userId,
    required String username,
    required String deviceId,
  }) async {
    await authBox.putAll({
      HiveKeys.serverUrl: serverUrl,
      HiveKeys.userId: userId,
      HiveKeys.username: username,
      HiveKeys.deviceId: deviceId,
    });
  }

  static Future<void> clearAuthData() async {
    await authBox.clear();
  }

  // ─── Settings helpers ───────────────────────────────────────────────────

  static bool get autoPlay =>
      settingsBox.get(HiveKeys.autoPlay, defaultValue: true) as bool;

  static bool get subtitlesEnabled =>
      settingsBox.get(HiveKeys.subtitlesEnabled, defaultValue: false) as bool;

  static String get subtitleLanguage =>
      settingsBox.get(HiveKeys.subtitleLanguage, defaultValue: 'eng') as String;

  static Future<void> saveSetting(String key, dynamic value) async {
    await settingsBox.put(key, value);
  }
}
