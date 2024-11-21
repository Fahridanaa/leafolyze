import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/image.dart';

class Article extends Equatable {
  final int id;
  final String title;
  final String content;
  final int duration;
  final Image? image;
  final String createdAt;
  final String updatedAt;

  const Article({
    required this.id,
    required this.title,
    required this.content,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      duration: json['duration'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'duration': duration,
      'image': image?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  Article copyWith({
    int? id,
    String? title,
    String? content,
    int? duration,
    Image? image,
    String? createdAt,
    String? updatedAt,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        duration,
        createdAt,
        updatedAt,
      ];

  String get readingTime => '$duration min read';
}
