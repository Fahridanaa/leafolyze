import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/history/history_event.dart';
import 'package:leafolyze/blocs/history/history_state.dart';
import 'package:leafolyze/repositories/detection_repository.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final DetectionRepository _repository;

  HistoryBloc(this._repository) : super(HistoryInitial()) {
    on<LoadDetections>(_onLoadDetections);
  }

  Future<void> _onLoadDetections(
    LoadDetections event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final detections = await _repository.getAllDetections();
      emit(HistoryLoaded(detections));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
