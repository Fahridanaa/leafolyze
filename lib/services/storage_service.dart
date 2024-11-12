import 'dart:convert';
import 'package:leafolyze/models/auth_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:leafolyze/models/user.dart';

class StorageService {
  static StorageService? _instance;
  static late SharedPreferences _prefs;

  static const String _userKey = 'user';
  static const String _tokenKey = 'auth_token';

  StorageService._();

  static Future<StorageService> init() async {
    if (_instance == null) {
      _instance = StorageService._();
      _prefs = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  Future<void> saveUser(User user) async {
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> saveToken(AuthToken token) async {
    await _prefs.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  User? getUser() {
    final userStr = _prefs.getString(_userKey);
    if (userStr != null) {
      return User.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  AuthToken? getToken() {
    final tokenStr = _prefs.getString(_tokenKey);
    if (tokenStr != null) {
      return AuthToken.fromJson(jsonDecode(tokenStr));
    }
    return null;
  }

  Future<void> removeUser() async {
    await _prefs.remove(_userKey);
  }

  Future<void> removeToken() async {
    await _prefs.remove(_tokenKey);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }

  bool get isAuthenticated {
    final token = getToken();
    return token != null && !token.isExpired;
  }
}
