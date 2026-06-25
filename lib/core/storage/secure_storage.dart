import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage(
    // Android: use EncryptedSharedPreferences
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    // iOS: accessible when unlocked
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // ─── Keys ───────────────────────────────────────────────────────────────

  static const _keyAccessToken = 'jellyfin_access_token';
  static const _keyDeviceId = 'jellyfin_device_id';

  // ─── Access Token ────────────────────────────────────────────────────────

  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _keyAccessToken, value: token);
  }

  static Future<String?> getAccessToken() async {
    return _storage.read(key: _keyAccessToken);
  }

  static Future<void> deleteAccessToken() async {
    await _storage.delete(key: _keyAccessToken);
  }

  // ─── Device ID ───────────────────────────────────────────────────────────

  static Future<void> saveDeviceId(String deviceId) async {
    await _storage.write(key: _keyDeviceId, value: deviceId);
  }

  static Future<String?> getDeviceId() async {
    return _storage.read(key: _keyDeviceId);
  }

  // ─── Clear All ───────────────────────────────────────────────────────────

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
