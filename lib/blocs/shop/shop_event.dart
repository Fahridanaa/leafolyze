import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class LoadShops extends ShopEvent {
  final int id;
  const LoadShops(this.id);

  @override
  List<Object> get props => [id];
}

