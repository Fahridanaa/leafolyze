import 'package:leafolyze/config/api_config.dart';
import 'package:leafolyze/models/auth_token.dart';
import 'package:leafolyze/models/user.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

class AuthRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthRepository(this._apiService, this._storageService);

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

      // Get user profile with the token
      final userResponse = await _apiService.get(
        ApiConfig.me,
        token: token.bearerToken,
      );

      // Save and return user
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
    final token = _storageService.getToken();
    if (token != null && !token.isExpired) {
      try {
        // Call logout endpoint
        await _apiService.post(
          ApiConfig.logout,
          {},
          token: token.bearerToken,
        );
      } catch (e) {
        print('Logout Error: $e');
      } finally {
        // Always clear local storage, even if API call fails
        await _storageService.removeToken();
        await _storageService.removeUser();
      }
    }
  }

  User? getCurrentUser() => _storageService.getUser();
  bool get isAuthenticated => _storageService.isAuthenticated;

  getCurrentToken() {}
}
