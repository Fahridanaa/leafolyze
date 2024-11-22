import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/image.dart';
import 'package:leafolyze/models/shop.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final int? shopId;
  final String description;
  final String price;
  final int? diseaseId;
  final Image? image;
  final String? createdAt;
  final String? updatedAt;
  final Shop? shop;

  const Product({
    required this.id,
    required this.name,
    this.shopId,
    required this.description,
    required this.price,
    this.diseaseId,
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
      diseaseId: json['disease_id'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      'disease_id': diseaseId,
      'image': image?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'shop': shop?.toJson(),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    int? shopId,
    String? description,
    String? price,
    int? diseaseId,
    Image? image,
    String? createdAt,
    String? updatedAt,
    Shop? shop,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      shopId: shopId ?? this.shopId,
      description: description ?? this.description,
      price: price ?? this.price,
      diseaseId: diseaseId ?? this.diseaseId,
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
        diseaseId,
        image,
        createdAt,
        updatedAt,
        shop,
      ];
}
