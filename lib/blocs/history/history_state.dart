import 'package:equatable/equatable.dart';
// import 'package:leafolyze/models/gambarML.dart';

abstract class GambarMLState extends Equatable {
  const GambarMLState();

  @override
  List<Object?> get props => [];
}

// Initial state
class GambarMLInitial extends GambarMLState {}

// Loading state
class GambarMLLoading extends GambarMLState {}

// Loaded state for all GambarML
// class GambarMLLoaded extends GambarMLState {
//   final List<GambarML> gambarMLList;

//   const GambarMLLoaded(this.gambarMLList);

//   @override
//   List<Object?> get props => [gambarMLList];
// }

// Error state
class GambarMLError extends GambarMLState {
  final String error;

  const GambarMLError(this.error);

  @override
  List<Object?> get props => [error];
}
