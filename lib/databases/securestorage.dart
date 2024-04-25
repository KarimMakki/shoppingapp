import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

// Used to save JWT token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

// Used to get saved JWT token
  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

// Used to delete saved JWT token
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}
