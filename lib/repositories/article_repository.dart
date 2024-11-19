import 'package:leafolyze/models/article.dart';
import 'package:leafolyze/services/api_service.dart';

class ArticleRepository {
  final ApiService _apiService;

  ArticleRepository(this._apiService);

  Future<List<Article>> getArticles() async {
    try {
      final response = await _apiService.get('/article');

      if (response['success']) {
        final List<dynamic> articlesJson = response['data'];
        print(articlesJson);
        return articlesJson.map((json) => Article.fromJson(json)).toList();
      }
      throw Exception(response['message']);
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load articles: $e');
    }
  }

  Future<List<Article>> searchArticles(String query) async {
    try {
      final response = await _apiService.get('/article/search', queryParams: {
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
