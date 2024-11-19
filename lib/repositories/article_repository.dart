import 'package:leafolyze/models/article.dart';
import 'package:leafolyze/services/api_service.dart';

class ArticleRepository {
  final ApiService _apiService;

  ArticleRepository(this._apiService);

  Future<List<Article>> getArticles() async {
    try {
      final response = await _apiService.get('/articles');

      if (response['success']) {
        final List<dynamic> articlesJson = response['data'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      }
      throw Exception(response['message']);
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }

  Future<Article> getArticleById(int id) async {
    try {
      final response = await _apiService.get('/articles/$id');

      if (response['success']) {
        return Article.fromJson(response['data']);
      }
      throw Exception(response['message']);
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load article: $e');
    }
  }

  Future<List<Article>> searchArticles(String query) async {
    try {
      final response = await _apiService.get('/articles/search', queryParams: {
        'q': query,
      });

      if (response['success']) {
        final List<dynamic> articlesJson = response['data'];
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      }
      throw Exception(response['message']);
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to search articles: $e');
    }
  }
}
