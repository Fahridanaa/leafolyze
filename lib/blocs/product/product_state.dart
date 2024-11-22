import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final String? sortOption;
  final String? searchQuery;

  const ProductLoaded({
    required this.products,
    this.sortOption,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [products, sortOption, searchQuery];

  ProductLoaded copyWith({
    List<Product>? products,
    String? sortOption,
    String? searchQuery,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      sortOption: sortOption ?? this.sortOption,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class SingleProductLoaded extends ProductState {
  final Product product;

  const SingleProductLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductUnauthorized extends ProductState {}
