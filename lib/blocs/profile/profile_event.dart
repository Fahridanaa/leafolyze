import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchProfile extends ProfileEvent {
  final int userId; 

  const FetchProfile(this.userId);

  @override
  List<Object?> get props => [userId];
}
