import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final int id;
  final int? userId;
  final String name;
  final String address;
  final String description;
  final String operational;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Shop({
    required this.id,
    this.userId,
    required this.name,
    required this.address,
    required this.description,
    required this.operational,
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
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Shop copyWith({
    int? id,
    int? userId,
    String? name,
    String? address,
    String? description,
    String? operational,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Shop(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      operational: operational ?? this.operational,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        address,
        description,
        operational,
        createdAt,
        updatedAt,
      ];
}
