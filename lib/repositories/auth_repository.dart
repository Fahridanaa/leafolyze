import 'package:dio/dio.dart';
import 'package:leafolyze/config/api_config.dart';
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

  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.post(ApiConfig.login, {
        'email': email,
        'password': password,
      });

      final token = AuthToken.fromJson({
        'access_token': response['access_token'],
        'token_type': response['token_type'],
        'expires_in': response['expires_in'],
      });
      await _storageService.saveToken(token);

      final userResponse = await _apiService.get(
        ApiConfig.me,
        token: token.bearerToken,
      );

      final user = User.fromJson(userResponse);
      await _storageService.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Future<User> register(String name, String email, String password) async {
  //   final response = await _apiService.post(ApiConfig.register, {
  //     'name': name,
  //     'email': email,
  //     'password': password,
  //     'password_confirmation': password,
  //   });

  //   final user = User.fromJson({
  //     ...response['user'],
  //     'token': response['token'],
  //   });

  //   await _storageService.saveUser(user);
  //   return user;
  // }

  Future<void> logout() async {
    final token = await _storageService.getToken();
    if (token != null && !token.isExpired) {
      try {
        await _apiService.post(
          ApiConfig.logout,
          {},
          token: token.bearerToken,
        );
      } catch (e) {
        print('Logout Error: $e');
      } finally {
        await _storageService.removeToken();
        await _storageService.removeUser();
      }
    }
  }

  Future<User?> getCurrentUser() async => await _storageService.getUser();
  Future<bool> isAuthenticated() async => await _storageService.isAuthenticated;
}
