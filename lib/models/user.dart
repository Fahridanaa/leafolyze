import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/user_detail.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String? emailVerifiedAt;
  final String access;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserDetail? userDetail;

  const User({
    required this.id,
    required this.email,
    this.emailVerifiedAt,
    required this.access,
    required this.createdAt,
    required this.updatedAt,
    this.userDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] ?? json;

    return User(
      id: int.parse(userData['id'].toString()),
      email: userData['email'],
      emailVerifiedAt: userData['email_verified_at'],
      access: userData['access'],
      createdAt: DateTime.parse(userData['created_at']),
      updatedAt: DateTime.parse(userData['updated_at']),
      userDetail: userData['user_detail'] != null
          ? UserDetail.fromJson(userData['user_detail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'Acces': access,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user_detail': userDetail?.toJson(),
    };
  }

  @override
  List<Object?> get props =>
      [id, email, emailVerifiedAt, access, createdAt, updatedAt, userDetail];
}
