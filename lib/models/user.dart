import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? token;
  final String? profileImage;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      profileImage: json['profile_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'profile_image': profileImage,
    };
  }

  @override
  List<Object?> get props => [id, name, email, token, profileImage];
}
