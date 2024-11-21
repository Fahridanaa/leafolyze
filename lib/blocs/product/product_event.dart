import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {}

// Add these new events
class LoadProductById extends ProductEvent {
  final int id;
  const LoadProductById(this.id);

  @override
  List<Object?> get props => [id];
}

class LoadProductsByShop extends ProductEvent {
  final int shopId;
  const LoadProductsByShop(this.shopId);

  @override
  List<Object?> get props => [shopId];
}

class LoadProductsByDisease extends ProductEvent {
  final int diseaseId;
  const LoadProductsByDisease(this.diseaseId);

  @override
  List<Object?> get props => [diseaseId];
}

class SearchProducts extends ProductEvent {
  final String query;
  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

class SortProducts extends ProductEvent {
  final String sortOption;
  const SortProducts(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}
