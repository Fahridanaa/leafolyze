import 'package:dio/dio.dart';
import 'package:leafolyze/config/api_config.dart';
import 'package:leafolyze/config/api_routes.dart';
import 'package:leafolyze/models/auth_token.dart';
import 'package:leafolyze/services/storage_service.dart';

class ApiService {
  late final Dio _dio;
  final StorageService _storageService;
  final Future<AuthToken> Function(AuthToken) refreshToken;

  ApiService(this._storageService, this.refreshToken) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.fullBaseUrl,
      headers: ApiConfig.headers,
      connectTimeout: ApiConfig.timeout,
      receiveTimeout: ApiConfig.timeout,
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    dynamic data,
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
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        throw UnauthorizedException();
      }
      throw ApiException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred: $e',
        statusCode: 500,
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
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        throw UnauthorizedException();
      }
      throw ApiException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred: $e',
        statusCode: 500,
      );
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    String? token,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
          },
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      if (e.error is UnauthorizedException) {
        throw UnauthorizedException();
      }
      throw ApiException(
        message: _handleDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException(
        message: 'An unexpected error occurred: $e',
        statusCode: 500,
      );
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      final responseData = response.data;

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('status') &&
          responseData.containsKey('message')) {
        switch (responseData['status']) {
          case 'error':
            throw ApiException(
              message: responseData['message'] ?? 'Unknown error occurred',
              statusCode: response.statusCode,
            );
          case 'fail':
            throw ApiException(
              message: responseData['message'] ?? 'Operation failed',
              statusCode: response.statusCode,
            );
          case 'success':
            return responseData;
        }
      }

      // Wrap non-standard responses in our standard format
      return {
        'status': 'success',
        'message': 'Success',
        'data': responseData,
      };
    }

    // Handle authentication errors
    if (response.data is Map && response.data['error'] == 'Unauthenticated') {
      _storageService.removeToken();
      throw UnauthorizedException();
    }

    throw ApiException(
      message: response.data['message'] ?? 'Something went wrong',
      statusCode: response.statusCode,
    );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip token check for login and refresh endpoints
    if (options.path != ApiRoutes.auth.login &&
        options.path != ApiRoutes.auth.refresh) {
      final token = await _storageService.getToken();
      if (token != null) {
        if (token.needsRefresh) {
          try {
            final newToken = await refreshToken(token);
            options.headers['Authorization'] = newToken.bearerToken;
          } catch (e) {
            // If refresh fails, continue with old token
            options.headers['Authorization'] = token.bearerToken;
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
      if (error.response?.data is Map &&
          error.response?.data['error'] == 'Unauthenticated') {
        await _storageService.removeToken();
        return handler.reject(
          DioException(
            requestOptions: error.requestOptions,
            error: UnauthorizedException(),
          ),
        );
      }

      // Try to refresh token
      try {
        final token = await _storageService.getToken();
        if (token != null) {
          final newToken = await refreshToken(token);
          final opts = error.requestOptions;
          opts.headers['Authorization'] = newToken.bearerToken;

          // Retry the original request with new token
          final response = await _dio.fetch(opts);
          return handler.resolve(response);
        }
      } catch (e) {
        await _storageService.removeToken();
        return handler.reject(
          DioException(
            requestOptions: error.requestOptions,
            error: UnauthorizedException(),
          ),
        );
      }
    }
    return handler.next(error);
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        final responseData = e.response?.data;
        if (responseData is Map<String, dynamic>) {
          return responseData['message'] ?? 'Server error occurred';
        }
        return 'Server error occurred';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.unknown:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          return 'No internet connection';
        }
        return 'An unexpected error occurred';
      default:
        return e.message ?? 'An unexpected error occurred';
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

class UnauthorizedException implements Exception {
  @override
  String toString() => 'Unauthenticated';
}
