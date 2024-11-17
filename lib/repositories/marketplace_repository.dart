import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/services/api_service.dart';

class MarketplaceRepository {
  final ApiService _apiService;

  MarketplaceRepository(this._apiService);

  Future<List<Product>> getProductsByType(String productType) async {
    try {
      final response = await _apiService.get('/products', queryParams: {
        'type': productType,
      });

      if (response['success']) {
        final List<dynamic> productsJson = response['data'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception(response['message']);
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await _apiService.get('/products');

      if (response['success']) {
        final List<dynamic> productsJson = response['data'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception(response['message']);
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
