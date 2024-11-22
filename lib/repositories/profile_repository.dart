import 'package:dio/dio.dart';
import 'package:leafolyze/config/api_routes.dart';
import 'package:leafolyze/models/api_response.dart';
import 'package:leafolyze/models/user.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

class ProfileRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  ProfileRepository(this._apiService, this._storageService);

  // Get user profile with details
  Future<User> getProfile() async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.get(
        ApiRoutes.profile.show,
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<User>.fromJson(
        response,
        (json) => User.fromJson(json),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data!;
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  // Update user profile
  Future<User> updateProfile({
    String? email,
    String? name,
    String? birth,
    String? gender,
    String? address,
    String? imagePath,
  }) async {
    try {
      final token = await _storageService.getToken();
      final data = <String, dynamic>{
        if (email != null) 'email': email,
        if (name != null) 'name': name,
        if (birth != null) 'birth': birth,
        if (gender != null) 'gender': gender,
        if (address != null) 'address': address,
      };

      // Create form data for multipart request if image is included
      final formData = FormData.fromMap(data);
      if (imagePath != null) {
        formData.files.add(
          MapEntry(
            'image',
            await MultipartFile.fromFile(imagePath),
          ),
        );
      }

      final response = await _apiService.post(
        ApiRoutes.profile.update,
        data: formData,
        token: token?.bearerToken,
      );

      final apiResponse = ApiResponse<User>.fromJson(
        response,
        (json) => User.fromJson(json),
      );

      if (!apiResponse.isSuccess) {
        throw Exception(apiResponse.message);
      }

      return apiResponse.data!;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Update password
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final token = await _storageService.getToken();
      final response = await _apiService.post(
        ApiRoutes.profile.updatePassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
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
      throw Exception('Failed to update password: $e');
    }
  }
}
