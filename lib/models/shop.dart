import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final int id;
  final int? userId;
  final String name;
  final String address;
  final String description;
  final String operational;
  final String gambarUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Shop({
    required this.id,
    this.userId,
    required this.name,
    required this.address,
    required this.description,
    required this.operational,
    required this.gambarUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      operational: json['operational'],
      gambarUrl: json['gambarUrl'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'address': address,
      'description': description,
      'operational': operational,
      'gambarUrl': gambarUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        address,
        description,
        operational,
        gambarUrl,
        createdAt,
        updatedAt,
      ];
}
