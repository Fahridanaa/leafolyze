import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/image.dart';
import 'package:leafolyze/models/shop.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int? shopId;
  final String description;
  final double price;
  final String type;
  final Image? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Shop? shop;

  const Product({
    required this.id,
    required this.name,
    this.shopId,
    required this.description,
    required this.price,
    required this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.shop,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      shopId: json['shop_id'],
      description: json['description'],
      price: json['price'],
      type: json['type'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
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
      'name': name,
      'shop_id': shopId,
      'description': description,
      'price': price,
      'type': type,
      'image': image?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'shop': shop?.toJson(),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    int? shopId,
    String? description,
    double? price,
    String? type,
    Image? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    Shop? shop,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      shopId: shopId ?? this.shopId,
      description: description ?? this.description,
      price: price ?? this.price,
      type: type ?? this.type,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      shop: shop ?? this.shop,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        shopId,
        description,
        price,
        type,
        image,
        createdAt,
        updatedAt,
        shop,
      ];
}
