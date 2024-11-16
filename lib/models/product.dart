import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/shop.dart';

class Product extends Equatable {
  final int id;
  final String imageUrl;
  final String name;
  final int? shopId;
  final String description;
  final String price;
  final String type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Shop? shop;

  const Product({
    required this.id,
    required this.imageUrl,
    required this.name,
    this.shopId,
    required this.description,
    required this.price,
    required this.type,
    this.createdAt,
    this.updatedAt,
    this.shop,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imageUrl: json['gambarUrl'],
      name: json['name'],
      shopId: json['shop_id'],
      description: json['description'],
      price: json['price'],
      type: json['type'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'shop_id': shopId,
      'description': description,
      'price': price,
      'type': type,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'shop': shop?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        name,
        shopId,
        description,
        price,
        type,
        createdAt,
        updatedAt,
        shop,
      ];
}
