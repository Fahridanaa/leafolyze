import 'package:leafolyze/models/user.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

class AuthRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthRepository(this._apiService, this._storageService);

  Future<User> login(String email, String password) async {
    final response = await _apiService.post('/auth/login', {
      'email': email,
      'password': password,
    });

    final user = User.fromJson(response['user']);
    await _storageService.saveUser(user);
    return user;
  }

  Future<User> register(String name, String email, String password) async {
    final response = await _apiService.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
    });

    final user = User.fromJson(response['user']);
    await _storageService.saveUser(user);
    return user;
  }

  Future<void> logout() async {
    final user = _storageService.getUser();
    if (user?.token != null) {
      try {
        await _apiService.post(
          '/auth/logout',
          {},
          token: user!.token,
        );
      } finally {
        await _storageService.removeUser();
      }
    }
  }

  User? getCurrentUser() => _storageService.getUser();
  bool get isAuthenticated => _storageService.isAuthenticated;
}
