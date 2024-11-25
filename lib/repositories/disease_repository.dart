import 'package:leafolyze/config/api_routes.dart';
import 'package:leafolyze/models/api_response.dart';
import 'package:leafolyze/models/disease.dart';
import 'package:leafolyze/services/api_service.dart';

class DiseaseRepository {
  final ApiService _apiService;

  DiseaseRepository(this._apiService);

  /// Fetches allases from the API
  Future<List<Disease>> getAllDiseases() async {
    try {
      final response = await _apiService.get(ApiRoutes.diseases.list);

      final apiResponse = ApiResponse<List<Disease>>.fromJson(
        response,
        (json) => (json as List).map((item) => Disease.fromJson(item)).toList(),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data ?? [];
    } catch (e) {
      throw Exception('Failed to fetch diseases: $e');
    }
  }

  /// Fetches a specific disease by its ID
  Future<Disease> getDiseaseById(int id) async {
    try {
      final response = await _apiService.get(ApiRoutes.diseases.show(id));

      final apiResponse = ApiResponse<Disease>.fromJson(
        response,
        (json) => Disease.fromJson(json),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data!;
    } catch (e) {
      throw Exception('Failed to fetch disease: $e');
    }
  }
}
