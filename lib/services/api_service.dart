import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leafolyze/config/api_config.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiConfig.baseUrl}$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else {
        throw ApiException(
          message: data['message'] ?? 'Something went wrong',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    String? token,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint').replace(
        queryParameters: queryParams,
      );

      final response = await _client.get(
        uri,
        headers: {
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return data;
      } else {
        throw ApiException(
          message: data['message'] ?? 'Something went wrong',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;
}
