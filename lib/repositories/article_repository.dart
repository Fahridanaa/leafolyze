import 'package:leafolyze/models/api_response.dart';
import 'package:leafolyze/models/article.dart';
import 'package:leafolyze/services/api_service.dart';

class ArticleRepository {
  final ApiService _apiService;

  ArticleRepository(this._apiService);

  Future<List<Article>> getArticles() async {
    try {
      final response = await _apiService.get('/articles');

      final apiResponse = ApiResponse<List<Article>>.fromJson(
        response,
        (json) => (json as List).map((item) => Article.fromJson(item)).toList(),
      );

      if (apiResponse.isSuccess) {
        return apiResponse.data ?? [];
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      throw Exception('Failed to fetch articles: $e');
    }
  }

  Future<Article> getArticleById(int id) async {
    try {
      final response = await _apiService.get('/articles/$id');

      final apiResponse = ApiResponse<Article>.fromJson(
        response,
        (json) => Article.fromJson(json),
      );

      if (apiResponse.isSuccess) {
        return apiResponse.data!;
      } else {
        throw Exception(apiResponse.message);
      }
    } catch (e) {
      throw Exception('Failed to fetch article: $e');
    }
  }
}
