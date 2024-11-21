// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:leafolyze/blocs/history/history_event.dart';
// import 'package:leafolyze/blocs/history/history_state.dart';
// import 'package:leafolyze/repositories/history_repository.dart';


// class GambarMLBloc extends Bloc<GambarMLEvent, GambarMLState> {
//   final GambarMLRepository repository;

//   GambarMLBloc(this.repository) : super(GambarMLInitial()) {
//     on<FetchAllGambarML>(_onFetchAllGambarML);
//     on<FetchGambarByUserId>(_onFetchGambarByUserId);
//   }

//   // Handle FetchAllGambarML event
//   Future<void> _onFetchAllGambarML(
//       FetchAllGambarML event, Emitter<GambarMLState> emit) async {
//     emit(GambarMLLoading());
//     try {
//       final gambarMLList = await repository.getGambarML();
//       emit(GambarMLLoaded(gambarMLList));
//     } catch (e) {
//       emit(GambarMLError('Failed to fetch all GambarML: $e'));
//     }
//   }


//   Future<void> _onFetchGambarByUserId(
//       FetchGambarByUserId event, Emitter<GambarMLState> emit) async {
//     emit(GambarMLLoading());
//     try {
//       final gambarMLList = await repository.getGambarByUserId(event.userId);
//       emit(GambarMLLoaded(gambarMLList));
//     } catch (e) {
//       emit(GambarMLError('Failed to fetch GambarML for userId ${event.userId}: $e'));
//     }
//   }
// }
