import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leafolyze/models/auth_token.dart';
import 'package:leafolyze/models/user.dart';

class StorageService {
  static StorageService? _instance;
  static late FlutterSecureStorage _secureStorage;

  static const String _userKey = 'user';
  static const String _tokenKey = 'auth_token';

  StorageService._() {
    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
  }

  static Future<StorageService> init() async {
    _instance ??= StorageService._();
    return _instance!;
  }

  Future<void> saveUser(User user) async {
    await _secureStorage.write(
      key: _userKey,
      value: jsonEncode(user.toJson()),
    );
  }

  Future<void> saveToken(AuthToken token) async {
    await _secureStorage.write(
      key: _tokenKey,
      value: jsonEncode(token.toJson()),
    );
  }

  Future<User?> getUser() async {
    final userStr = await _secureStorage.read(key: _userKey);
    if (userStr != null) {
      return User.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  Future<AuthToken?> getToken() async {
    final tokenStr = await _secureStorage.read(key: _tokenKey);
    if (tokenStr != null) {
      return AuthToken.fromJson(jsonDecode(tokenStr));
    }
    return null;
  }

  Future<void> removeUser() async {
    await _secureStorage.delete(key: _userKey);
  }

  Future<void> removeToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  Future<bool> get isAuthenticated async {
    final token = await getToken();
    return token != null && !token.needsRefresh && token.accessToken.isNotEmpty;
  }
}
