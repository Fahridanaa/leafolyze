import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/article.dart';
import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/models/shop.dart';
import 'package:leafolyze/models/tomato_leaf_detection.dart';
import 'package:leafolyze/models/user_detail.dart';

enum ImageType { article, user_detail, tomato_leaf_detection, shop, product }

class Image extends Equatable {
  final int? id;
  final String path;
  final String publicId;
  final ImageType type;
  final int? articleId;
  final int? userDetailId;
  final int? tomatoLeafDetectionId;
  final int? shopId;
  final int? productId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Relationships
  final Article? article;
  final UserDetail? userDetail;
  final TomatoLeafDetection? tomatoLeafDetection;
  final Shop? shop;
  final Product? product;

  const Image({
    this.id,
    required this.path,
    required this.publicId,
    required this.type,
    this.articleId,
    this.userDetailId,
    this.tomatoLeafDetectionId,
    this.shopId,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.article,
    this.userDetail,
    this.tomatoLeafDetection,
    this.shop,
    this.product,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      path: json['path'],
      publicId: json['public_id'],
      type: ImageType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      articleId: json['article_id'],
      userDetailId: json['user_detail_id'],
      tomatoLeafDetectionId: json['tomato_leaf_detection_id'],
      shopId: json['shop_id'],
      productId: json['product_id'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      article:
          json['article'] != null ? Article.fromJson(json['article']) : null,
      userDetail: json['user_detail'] != null
          ? UserDetail.fromJson(json['user_detail'])
          : null,
      tomatoLeafDetection: json['tomato_leaf_detection'] != null
          ? TomatoLeafDetection.fromJson(json['tomato_leaf_detection'])
          : null,
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'public_id': publicId,
      'type': type.toString().split('.').last,
      'article_id': articleId,
      'user_detail_id': userDetailId,
      'tomato_leaf_detection_id': tomatoLeafDetectionId,
      'shop_id': shopId,
      'product_id': productId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'article': article?.toJson(),
      'user_detail': userDetail?.toJson(),
      'tomato_leaf_detection': tomatoLeafDetection?.toJson(),
      'shop': shop?.toJson(),
      'product': product?.toJson(),
    };
  }

  Image copyWith({
    int? id,
    String? path,
    String? publicId,
    ImageType? type,
    int? articleId,
    int? userDetailId,
    int? tomatoLeafDetectionId,
    int? shopId,
    int? productId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Article? article,
    UserDetail? userDetail,
    TomatoLeafDetection? tomatoLeafDetection,
    Shop? shop,
    Product? product,
  }) {
    return Image(
      id: id ?? this.id,
      path: path ?? this.path,
      publicId: publicId ?? this.publicId,
      type: type ?? this.type,
      articleId: articleId ?? this.articleId,
      userDetailId: userDetailId ?? this.userDetailId,
      tomatoLeafDetectionId:
          tomatoLeafDetectionId ?? this.tomatoLeafDetectionId,
      shopId: shopId ?? this.shopId,
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      article: article ?? this.article,
      userDetail: userDetail ?? this.userDetail,
      tomatoLeafDetection: tomatoLeafDetection ?? this.tomatoLeafDetection,
      shop: shop ?? this.shop,
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [
        id,
        path,
        publicId,
        type,
        articleId,
        userDetailId,
        tomatoLeafDetectionId,
        shopId,
        productId,
        createdAt,
        updatedAt,
        article,
        userDetail,
        tomatoLeafDetection,
        shop,
        product
      ];
}
