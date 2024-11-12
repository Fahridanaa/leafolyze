import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:leafolyze/models/user.dart';

class StorageService {
  static StorageService? _instance;
  static late SharedPreferences _prefs;

  static const String _userKey = 'user';

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

  User? getUser() {
    final userStr = _prefs.getString(_userKey);
    if (userStr != null) {
      return User.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  Future<void> removeUser() async {
    await _prefs.remove(_userKey);
  }

  bool get isAuthenticated => getUser()?.token != null;

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
