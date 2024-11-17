import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/product.dart';

abstract class MarketplaceState extends Equatable {
  const MarketplaceState();

  @override
  List<Object?> get props => [];
}

class MarketplaceInitial extends MarketplaceState {}

class MarketplaceLoading extends MarketplaceState {}

class MarketplaceLoaded extends MarketplaceState {
  final List<Product> products;
  final String? sortOption;
  final String? filterOption;
  final String? searchQuery;

  const MarketplaceLoaded({
    required this.products,
    this.sortOption,
    this.filterOption,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [products, sortOption, filterOption, searchQuery];

  MarketplaceLoaded copyWith({
    List<Product>? products,
    String? sortOption,
    String? filterOption,
    String? searchQuery,
  }) {
    return MarketplaceLoaded(
      products: products ?? this.products,
      sortOption: sortOption ?? this.sortOption,
      filterOption: filterOption ?? this.filterOption,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class MarketplaceError extends MarketplaceState {
  final String message;

  const MarketplaceError(this.message);

  @override
  List<Object?> get props => [message];
}

class MarketplaceUnauthorized extends MarketplaceState {}
