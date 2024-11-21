import 'package:leafolyze/models/user_detail.dart';
import 'package:leafolyze/services/api_service.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<List<UserDetail>> getUserDetail(int userId) async {
    try {
      final response = await _apiService.get('/userdetail', queryParams: {
        'user_id': userId,
      });

      if (response['success']) {
        final List<dynamic> userDetailJson = response['data'];
        return userDetailJson.map((json) => UserDetail.fromJson(json)).toList();
      }
      throw Exception(response['message']);
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load UserDetail: $e');
    }
  }
}
