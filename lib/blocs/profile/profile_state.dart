import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/user_detail.dart';


abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<UserDetail> profiles;

  const ProfileLoaded(this.profiles);

  @override
  List<Object?> get props => [profiles];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
