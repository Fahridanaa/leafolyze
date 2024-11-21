import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String? email;
  final String? name;
  final String? birth;
  final String? gender;
  final String? address;
  final String? imagePath;

  const UpdateProfile({
    this.email,
    this.name,
    this.birth,
    this.gender,
    this.address,
    this.imagePath,
  });

  @override
  List<Object?> get props => [email, name, birth, gender, address, imagePath];
}

class UpdatePassword extends ProfileEvent {
  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  const UpdatePassword({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  @override
  List<Object> get props =>
      [currentPassword, newPassword, newPasswordConfirmation];
}
