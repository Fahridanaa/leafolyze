import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String? birth;
  final String? gender;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserDetail({
    required this.id,
    required this.userId,
    required this.name,
    this.birth,
    this.gender,
    this.address,
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  UserDetail copyWith({
    int? id,
    int? userId,
    String? name,
    String? birth,
    String? gender,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserDetail(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      birth: birth ?? this.birth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        birth,
        gender,
        address,
        createdAt,
        updatedAt,
      ];
}
