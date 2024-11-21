import 'package:dio/dio.dart';
import 'package:leafolyze/config/api_routes.dart';
import 'package:leafolyze/models/api_response.dart';
import 'package:leafolyze/models/auth_token.dart';
import 'package:leafolyze/models/user.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

class AuthRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthRepository(this._apiService, this._storageService);

  Future<void> refreshTokenIfNeeded() async {
    final token = await _storageService.getToken();
    if (token != null && token.needsRefresh) {
      try {
        await _apiService.refreshToken(token);
      } catch (e) {
        print('Token refresh failed: $e');
        if (e is DioException && e.response?.statusCode == 401) {
          await logout();
        }
      }
    }
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.auth.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
        response,
        (json) => json as Map<String, dynamic>,
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      // Handle token
      final tokenData = apiResponse.data!;
      final token = AuthToken.fromJson({
        'access_token': tokenData['access_token'],
        'token_type': tokenData['token_type'],
        'expires_in': tokenData['expires_in'],
      });
      await _storageService.saveToken(token);

      // Get user details
      final userResponse = await _apiService.get(
        ApiRoutes.auth.me,
        token: token.bearerToken,
      );

      final userApiResponse = ApiResponse<User>.fromJson(
        userResponse,
        (json) => User.fromJson(json),
      );

      if (!userApiResponse.isSuccess) {
        throw Exception(userApiResponse.message);
      }

      final user = userApiResponse.data!;
      await _storageService.saveUser(user);
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String birth,
    required String gender,
    required String address,
    String? access,
  }) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.auth.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'birth': birth,
          'gender': gender,
          'address': address,
          'access': access ?? 'petani',
        },
      );

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
        response,
        (json) => json as Map<String, dynamic>,
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      // Handle token
      final tokenData = apiResponse.data!;
      final token = AuthToken.fromJson({
        'access_token': tokenData['access_token'],
        'token_type': tokenData['token_type'],
        'expires_in': tokenData['expires_in'],
      });
      await _storageService.saveToken(token);

      // Get user details after registration
      final userResponse = await _apiService.get(
        ApiRoutes.auth.me,
        token: token.bearerToken,
      );

      final userApiResponse = ApiResponse<User>.fromJson(
        userResponse,
        (json) => User.fromJson(json),
      );

      if (!userApiResponse.isSuccess) {
        throw Exception(userApiResponse.message);
      }

      final user = userApiResponse.data!;
      await _storageService.saveUser(user);
      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      final token = await _storageService.getToken();
      if (token != null) {
        await _apiService.post(
          ApiRoutes.auth.logout,
          token: token.bearerToken,
        );
      }
      await _storageService.removeToken();
      await _storageService.removeUser();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<AuthToken> refresh(AuthToken currentToken) async {
    try {
      final response = await _apiService.post(
        ApiRoutes.auth.refresh,
        token: currentToken.bearerToken,
      );

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
        response,
        (json) => json as Map<String, dynamic>,
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      final tokenData = apiResponse.data!;
      final newToken = AuthToken.fromJson({
        'access_token': tokenData['access_token'],
        'token_type': tokenData['token_type'],
        'expires_in': tokenData['expires_in'],
      });

      await _storageService.saveToken(newToken);
      return newToken;
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  Future<User?> getCurrentUser() async {
    return await _storageService.getUser();
  }

  Future<bool> isAuthenticated() async {
    final token = await _storageService.getToken();
    return token != null && !token.isExpired;
  }
}
