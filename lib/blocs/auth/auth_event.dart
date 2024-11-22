import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String birth;
  final String gender;
  final String address;
  final String? access;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.birth,
    required this.gender,
    required this.address,
    this.access,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        birth,
        gender,
        address,
        access,
      ];
}

class LogoutRequested extends AuthEvent {}
