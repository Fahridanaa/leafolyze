import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/profile/profile_event.dart';
import 'package:leafolyze/blocs/profile/profile_state.dart';
import 'package:leafolyze/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdatePassword>(_onUpdatePassword);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await repository.getProfile();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await repository.updateProfile(
        email: event.email,
        name: event.name,
        birth: event.birth,
        gender: event.gender,
        address: event.address,
        imagePath: event.imagePath,
      );
      emit(ProfileLoaded(user));
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdatePassword(
    UpdatePassword event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      await repository.updatePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        newPasswordConfirmation: event.newPasswordConfirmation,
      );
      emit(PasswordUpdateSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
