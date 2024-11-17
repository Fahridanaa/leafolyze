import 'package:equatable/equatable.dart';

abstract class MarketplaceEvent extends Equatable {
  const MarketplaceEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends MarketplaceEvent {}

class LoadProductsByType extends MarketplaceEvent {
  final String productType;

  const LoadProductsByType(this.productType);

  @override
  List<Object?> get props => [productType];
}

class SearchProducts extends MarketplaceEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class SortProducts extends MarketplaceEvent {
  final String sortOption;

  const SortProducts(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

class FilterProducts extends MarketplaceEvent {
  final String filterOption;

  const FilterProducts(this.filterOption);

  @override
  List<Object?> get props => [filterOption];
}
