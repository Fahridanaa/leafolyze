// import 'package:leafolyze/models/gambarML.dart';
// import 'package:leafolyze/services/api_service.dart';

// class GambarMLRepository {
//   final ApiService _apiService;

//   GambarMLRepository(this._apiService);

//   // Fetch GambarML by userId
//   Future<List<GambarML>> getGambarByUserId(int userId) async {
//     try {
//       final response = await _apiService.get('/machinelearning', queryParams: {
//         'user_id': userId,
//       });

//       if (response['success']) {
//         final List<dynamic> gambarJson = response['data'];
//         return gambarJson.map((json) => GambarML.fromJson(json)).toList();
//       }
//       throw Exception(response['message']);
//     } on UnauthorizedException {
//       rethrow;
//     } catch (e) {
//       throw Exception('Failed to load GambarML: $e');
//     }
//   }

//   // Fetch all GambarML
//   Future<List<GambarML>> getGambarML() async {
//     try {
//       final response = await _apiService.get('/machinelearning');

//       if (response['success']) {
//         final List<dynamic> gambarJson = response['data'];
//         return gambarJson.map((json) => GambarML.fromJson(json)).toList();
//       }
//       throw Exception(response['message']);
//     } on UnauthorizedException {
//       rethrow;
//     } catch (e) {
//       throw Exception('Failed to load GambarML: $e');
//     }
//   }
// }
