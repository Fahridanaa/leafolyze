import 'package:leafolyze/config/api_routes.dart';
import 'package:leafolyze/models/api_response.dart';
import 'package:leafolyze/models/shop.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

class ShopRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  ShopRepository(this._apiService, this._storageService);

  Future<List<Shop>> getShop() async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.shop.list,
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<List<Shop>>.fromJson(
        response,
        (json) => (json as List).map((item) => Shop.fromJson(item)).toList(),
      );

      if (apiResponse.isSuccess) {
        return apiResponse.data ?? [];
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      throw Exception('Failed to fetch Shop: $e');
    }
  }

  Future<Shop> getShopById(int id) async {
    try {
      final response = await _apiService.get('/shop/$id');

      final apiResponse = ApiResponse<Shop>.fromJson(
        response,
        (json) => Shop.fromJson(json),
      );

      if (apiResponse.isSuccess) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      throw Exception('Failed to fetch Shop: $e');
    }
  }
}
