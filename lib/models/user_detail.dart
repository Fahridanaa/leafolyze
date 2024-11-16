import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String? birth;
  final String? gender;
  final String? address;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserDetail({
    required this.id,
    required this.userId,
    required this.name,
    this.birth,
    this.gender,
    this.address,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      name: json['name'],
      birth: json['birth'],
      gender: json['gender'],
      address: json['address'],
      imageUrl: json['gambarUrl'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'birth': birth,
      'gender': gender,
      'address': address,
      'imageUrl': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        birth,
        gender,
        address,
        imageUrl,
        createdAt,
        updatedAt,
      ];
}
