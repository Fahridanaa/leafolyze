import 'dart:io';

class ApiConfig {
  // TODO: Change this api URL
  static String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8000/api' // Android Emulator
      : 'http://127.0.0.1:8000/api'; // iOS Simulator
  static const int timeout = 30000; // 30 seconds

  static const String login = '/login';
  static const String me = '/me';
  static const String refresh = '/refresh';
  static const String register = '/register';
  static const String logout = '/logout';
}
