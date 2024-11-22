import 'package:dio/dio.dart';
import 'package:leafolyze/config/api_routes.dart';
import 'package:leafolyze/models/api_response.dart';
import 'package:leafolyze/models/tomato_leaf_detection.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

class DetectionRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  DetectionRepository(this._apiService, this._storageService);

  Future<List<TomatoLeafDetection>> getAllDetections() async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.detections.list,
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<List<TomatoLeafDetection>>.fromJson(
        response,
        (json) => (json as List)
            .map((item) => TomatoLeafDetection.fromJson(item))
            .toList(),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data ?? [];
    } catch (e) {
      throw Exception('Failed to fetch detections: $e');
    }
  }

  Future<TomatoLeafDetection> getDetectionById(int id) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.detections.show(id),
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<TomatoLeafDetection>.fromJson(
        response,
        (json) => TomatoLeafDetection.fromJson(json),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data!;
    } catch (e) {
      throw Exception('Failed to fetch detection: $e');
    }
  }

  Future<TomatoLeafDetection> createDetection({
    required String title,
    required String imagePath,
    List<int>? diseaseIds,
  }) async {
    try {
      final token = await _storageService.getToken();

      // Create form data for multipart request
      final formData = FormData.fromMap({
        'title': title,
        'image': await MultipartFile.fromFile(imagePath),
        if (diseaseIds != null) 'disease_ids[]': diseaseIds,
      });

      final response = await _apiService.post(
        ApiRoutes.detections.create(),
        data: formData,
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<TomatoLeafDetection>.fromJson(
        response,
        (json) => TomatoLeafDetection.fromJson(json),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data!;
    } catch (e) {
      throw Exception('Failed to create detection: $e');
    }
  }

  Future<TomatoLeafDetection> updateDetection({
    required int id,
    String? title,
    String? imagePath,
    List<int>? diseaseIds,
  }) async {
    try {
      final token = await _storageService.getToken();

      // Create form data for multipart request
      final formData = FormData.fromMap({
        if (title != null) 'title': title,
        if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
        if (diseaseIds != null) 'disease_ids[]': diseaseIds,
      });

      final response = await _apiService.post(
        ApiRoutes.detections.update(id),
        data: formData,
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<TomatoLeafDetection>.fromJson(
        response,
        (json) => TomatoLeafDetection.fromJson(json),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data!;
    } catch (e) {
      throw Exception('Failed to update detection: $e');
    }
  }

  Future<void> deleteDetection(int id) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.delete(
        ApiRoutes.detections.delete(id),
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<void>.fromJson(
        response,
        (_) {},
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      throw Exception('Failed to delete detection: $e');
    }
  }
}
