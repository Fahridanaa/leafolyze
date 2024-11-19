import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String content;
  final String gambarUrl;
  final int duration;
  final String createdAt;
  final String updatedAt;

  const Article({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.gambarUrl,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      content: json['content'],
      gambarUrl: json['gambarUrl'],
      duration: json['duration'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'gambarUrl': gambarUrl,
      'duration': duration,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        content,
        gambarUrl,
        duration,
        createdAt,
        updatedAt,
      ];
}

// // Helper class to parse the API response
// class ArtikelResponse {
//   final bool success;
//   final String message;
//   final List<Article> data;

//   const ArticleResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory ArticleResponse.fromJson(Map<String, dynamic> json) {
//     return ArticleResponse(
//       success: json['success'],
//       message: json['message'],
//       data:
//           (json['data'] as List).map((item) => Article.fromJson(item)).toList(),
//     );
//   }
// }
