import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/models/tomato_leaf_detection.dart';

class Disease extends Equatable {
  final int? id;
  final String name;
  final String description;
  final List<TomatoLeafDetection>? detections;
  final List<Product>? products;

  Disease({
    this.id,
    required this.name,
    required this.description,
    this.detections,
    this.products,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      detections: json['detections'] != null
          ? List<TomatoLeafDetection>.from(
              json['detections'].map((x) => TomatoLeafDetection.fromJson(x)))
          : null,
      products: json['products'] != null
          ? List<Product>.from(json['products'].map((x) => Product.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'detections': detections?.map((x) => x.toJson()).toList(),
      'products': products?.map((x) => x.toJson()).toList(),
    };
  }

  Disease copyWith({
    int? id,
    String? name,
    String? description,
    List<TomatoLeafDetection>? detections,
    List<Product>? products,
  }) {
    return Disease(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      detections: detections ?? this.detections,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [id, name, description, detections, products];
}
