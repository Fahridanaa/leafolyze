import 'package:bloc/bloc.dart';
import 'package:leafolyze/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
  }

  Future<void> _onFetchProfile(
      FetchProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getUserDetail(event.userId);
      emit(ProfileLoaded(profile)); 
    } catch (e) {
      emit(ProfileError('Failed to fetch profile: $e'));
    }
  }
}
