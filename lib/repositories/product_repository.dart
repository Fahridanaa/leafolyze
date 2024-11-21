import 'package:leafolyze/config/api_routes.dart';
import 'package:leafolyze/models/api_response.dart';
import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

class ProductRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  ProductRepository(this._apiService, this._storageService);

  Future<List<Product>> getAllProducts() async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.products.list,
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<List<Product>>.fromJson(
        response,
        (json) => (json as List).map((item) => Product.fromJson(item)).toList(),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data ?? [];
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.products.show(id),
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<Product>.fromJson(
        response,
        (json) => Product.fromJson(json),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data!;
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  Future<List<Product>> getProductsByShop(int shopId) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.products.byShop(shopId),
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<List<Product>>.fromJson(
        response,
        (json) => (json as List).map((item) => Product.fromJson(item)).toList(),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data ?? [];
    } catch (e) {
      throw Exception('Failed to fetch shop products: $e');
    }
  }

  Future<List<Product>> getProductsByDisease(int diseaseId) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.products.byDisease(diseaseId),
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<List<Product>>.fromJson(
        response,
        (json) => (json as List).map((item) => Product.fromJson(item)).toList(),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data ?? [];
    } catch (e) {
      throw Exception('Failed to fetch disease products: $e');
    }
  }
}
