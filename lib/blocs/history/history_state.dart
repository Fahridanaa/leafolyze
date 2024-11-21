import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/tomato_leaf_detection.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<TomatoLeafDetection> detections;

  const HistoryLoaded(this.detections);

  @override
  List<Object?> get props => [detections];
}

class HistoryError extends HistoryState {
  final String error;

  const HistoryError(this.error);

  @override
  List<Object?> get props => [error];
}
