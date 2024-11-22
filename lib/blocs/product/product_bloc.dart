import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/product/product_event.dart';
import 'package:leafolyze/blocs/product/product_state.dart';
import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/repositories/product_repository.dart';
import 'package:leafolyze/services/api_service.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _repository;
  List<Product> _allProducts = [];

  ProductBloc(this._repository) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductById>(_onLoadProductById);
    on<LoadProductsByShop>(_onLoadProductsByShop);
    on<LoadProductsByDisease>(_onLoadProductsByDisease);
    on<SearchProducts>(_onSearchProducts);
    on<SortProducts>(_onSortProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      _allProducts = await _repository.getAllProducts();
      emit(ProductLoaded(products: _allProducts));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(ProductUnauthorized());
      } else {
        emit(ProductError(e.toString()));
      }
    }
  }

  Future<void> _onLoadProductById(
    LoadProductById event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final product = await _repository.getProductById(event.id);
      emit(SingleProductLoaded(product));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(ProductUnauthorized());
      } else {
        emit(ProductError(e.toString()));
      }
    }
  }

  Future<void> _onLoadProductsByShop(
    LoadProductsByShop event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      _allProducts = await _repository.getProductsByShop(event.shopId);
      emit(ProductLoaded(products: _allProducts));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(ProductUnauthorized());
      } else {
        emit(ProductError(e.toString()));
      }
    }
  }

  Future<void> _onLoadProductsByDisease(
    LoadProductsByDisease event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      _allProducts = await _repository.getProductsByDisease(event.diseaseId);
      emit(ProductLoaded(products: _allProducts));
    } catch (e) {
      if (e is UnauthorizedException) {
        emit(ProductUnauthorized());
      } else {
        emit(ProductError(e.toString()));
      }
    }
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final filteredProducts = _allProducts
          .where((product) =>
              product.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ProductLoaded(
        products: filteredProducts,
        searchQuery: event.query,
      ));
    }
  }

  void _onSortProducts(
    SortProducts event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      final sortedProducts = List<Product>.from(currentState.products);

      switch (event.sortOption) {
        case 'Price: Low to High':
          sortedProducts.sort(
              (a, b) => (int.parse(a.price)).compareTo(int.parse(b.price)));
          break;
        case 'Price: High to Low':
          sortedProducts.sort(
              (a, b) => (int.parse(b.price)).compareTo(int.parse(a.price)));
          break;
        case 'Recently Added':
          sortedProducts.sort((a, b) => (DateTime.parse(
                  b.createdAt ?? DateTime.now().toString()))
              .compareTo(
                  DateTime.parse(a.createdAt ?? DateTime.now().toString())));
          break;
      }

      emit(ProductLoaded(
        products: sortedProducts,
        sortOption: event.sortOption,
      ));
    }
  }
}
