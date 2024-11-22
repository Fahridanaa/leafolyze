import 'dart:io';

class ApiConfig {
  // static const String baseUrl = 'https://api.yourdomain.com'; // Production
  static String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8000' // Android Emulator
      : 'http://127.0.0.1:8000'; // iOS Simulator

  static const String apiVersion = 'v1';
  static const Duration timeout = Duration(seconds: 30);

  // Headers
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // Endpoints base path
  static const String apiPath = '/api';

  // Full base URL
  static String get fullBaseUrl => '$baseUrl$apiPath/';
}
