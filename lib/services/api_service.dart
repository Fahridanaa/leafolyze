import 'package:dio/dio.dart';
import 'package:leafolyze/config/api_config.dart';
import 'package:leafolyze/models/auth_token.dart';
import 'package:leafolyze/services/storage_service.dart';

class ApiService {
  late final Dio _dio;
  final StorageService _storageService;

  ApiService(this._storageService) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConfig.timeout),
      receiveTimeout: Duration(milliseconds: ApiConfig.timeout),
      contentType: 'application/json',
      validateStatus: (status) => status! < 500,
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path != ApiConfig.login && options.path != ApiConfig.refresh) {
      final token = await _storageService.getToken();
      if (token != null) {
        if (token.needsRefresh) {
          // Refresh token before making the request
          try {
            final newToken = await refreshToken(token);
            options.headers['Authorization'] = newToken.bearerToken;
            return handler.next(options);
          } catch (e) {
            // If refresh fails, continue with old token
            options.headers['Authorization'] = token.bearerToken;
            return handler.next(options);
          }
        } else {
          options.headers['Authorization'] = token.bearerToken;
        }
      }
    }
    return handler.next(options);
  }

  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (error.response?.statusCode == 401) {
      // Token might be expired, try to refresh
      try {
        final token = await _storageService.getToken();
        if (token != null) {
          final newToken = await refreshToken(token);
          // Retry the original request with new token
          final opts = error.requestOptions;
          opts.headers['Authorization'] = newToken.bearerToken;
          final response = await _dio.fetch(opts);
          return handler.resolve(response);
        }
      } catch (e) {
        // If refresh fails, proceed with original error
        print('Token refresh failed: $e');
      }
    }
    return handler.next(error);
  }

  Future<AuthToken> refreshToken(AuthToken oldToken) async {
    try {
      final response = await _dio.post(
        ApiConfig.refresh,
        options: Options(
          headers: {'Authorization': oldToken.bearerToken},
        ),
      );

      final newToken = AuthToken.fromJson({
        'access_token': response.data['token'],
        'token_type': oldToken.tokenType,
        'expires_in': oldToken.expiresIn,
      });

      await _storageService.saveToken(newToken);
      return newToken;
    } catch (e) {
      print('Refresh token error: $e');
      rethrow;
    }
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
