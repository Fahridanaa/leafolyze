import 'package:equatable/equatable.dart';

abstract class GambarMLEvent extends Equatable {
  const GambarMLEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllGambarML extends GambarMLEvent {}

class FetchGambarByUserId extends GambarMLEvent {
  final int userId;

  const FetchGambarByUserId(this.userId);

  @override
  List<Object?> get props => [userId];
}
