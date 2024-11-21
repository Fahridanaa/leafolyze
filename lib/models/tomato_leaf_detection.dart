import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/disease.dart';
import 'package:leafolyze/models/image.dart';
import 'package:leafolyze/models/user.dart';

class TomatoLeafDetection extends Equatable {
  final int? id;
  final int userId;
  final String title;
  final User? user;
  final List<Disease>? diseases;
  final Image? image;

  const TomatoLeafDetection({
    this.id,
    required this.userId,
    required this.title,
    this.user,
    this.diseases,
    this.image,
  });

  factory TomatoLeafDetection.fromJson(Map<String, dynamic> json) {
    return TomatoLeafDetection(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      diseases: json['diseases'] != null
          ? List<Disease>.from(json['diseases'].map((x) => Disease.fromJson(x)))
          : null,
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'user': user?.toJson(),
      'diseases': diseases?.map((x) => x.toJson()).toList(),
      'image': image?.toJson(),
    };
  }

  TomatoLeafDetection copyWith({
    int? id,
    int? userId,
    String? title,
    User? user,
    List<Disease>? diseases,
    Image? image,
  }) {
    return TomatoLeafDetection(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      user: user ?? this.user,
      diseases: diseases ?? this.diseases,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, userId, title];
}
