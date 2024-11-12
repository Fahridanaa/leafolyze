import 'package:dio/dio.dart';
import 'package:leafolyze/config/api_config.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConfig.timeout),
      receiveTimeout: Duration(milliseconds: ApiConfig.timeout),
      contentType: 'application/json',
      validateStatus: (status) => status! < 500,
    ));
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    String? token,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw ApiException(
          message: response.data['message'] ?? 'Something went wrong',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data?['message'] ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    String? token,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data;
      } else {
        throw ApiException(
          message: response.data['message'] ?? 'Something went wrong',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        message: e.response?.data?['message'] ?? e.message ?? 'Network error',
        statusCode: e.response?.statusCode,
      );
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
