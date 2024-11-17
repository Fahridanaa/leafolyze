import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/marketplace/marketplace_event.dart';
import 'package:leafolyze/blocs/marketplace/marketplace_state.dart';
import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/repositories/marketplace_repository.dart';
import 'package:leafolyze/services/api_service.dart';

class MarketplaceBloc extends Bloc<MarketplaceEvent, MarketplaceState> {
  final MarketplaceRepository _repository;
  List<Product> _allProducts = [];

  MarketplaceBloc(this._repository) : super(MarketplaceInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductsByType>(_onLoadProductsByType);
    on<SearchProducts>(_onSearchProducts);
    on<SortProducts>(_onSortProducts);
    on<FilterProducts>(_onFilterProducts);
  }

  Future<void> _onLoadProductsByType(
    LoadProductsByType event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(MarketplaceLoading());
    try {
      _allProducts = await _repository.getProductsByType(event.productType);
      emit(MarketplaceLoaded(
        products: _allProducts,
        filterOption: event.productType,
      ));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(MarketplaceUnauthorized());
      } else {
        emit(MarketplaceError(e.toString()));
      }
    }
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<MarketplaceState> emit,
  ) async {
    emit(MarketplaceLoading());
    try {
      _allProducts = await _repository.getProducts();
      emit(MarketplaceLoaded(products: _allProducts));
    } catch (e) {
      emit(MarketplaceError(e.toString()));
    }
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<MarketplaceState> emit,
  ) {
    if (state is MarketplaceLoaded) {
      final filteredProducts = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(MarketplaceLoaded(
        products: filteredProducts,
        searchQuery: event.query,
      ));
    }
  }

  void _onSortProducts(
    SortProducts event,
    Emitter<MarketplaceState> emit,
  ) {
    if (state is MarketplaceLoaded) {
      final currentState = state as MarketplaceLoaded;
      final sortedProducts = List<Product>.from(currentState.products);

      switch (event.sortOption) {
        case 'Price: Low to High':
          sortedProducts
              .sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));
          break;
        case 'Price: High to Low':
          sortedProducts
              .sort((a, b) => int.parse(b.price).compareTo(int.parse(a.price)));
          break;
        case 'Recently Added':
          sortedProducts.sort((a, b) => (b.createdAt ?? DateTime.now())
              .compareTo(a.createdAt ?? DateTime.now()));
          break;
      }

      emit(MarketplaceLoaded(
        products: sortedProducts,
        sortOption: event.sortOption,
      ));
    }
  }

  void _onFilterProducts(
    FilterProducts event,
    Emitter<MarketplaceState> emit,
  ) {
    if (state is MarketplaceLoaded) {
      final filteredProducts = _allProducts
          .where((product) =>
              event.filterOption == 'All' || product.type == event.filterOption)
          .toList();
      emit(MarketplaceLoaded(
        products: filteredProducts,
        filterOption: event.filterOption,
      ));
    }
  }
}
