import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final DateTime createdAt;

  const AuthToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.createdAt,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    final accessToken = json['access_token']?.toString();
    final tokenType = json['token_type']?.toString().toLowerCase();
    final expiresIn = json['expires_in'];
    final createdAt = DateTime.now();

    return AuthToken(
      accessToken: accessToken ?? '',
      tokenType: tokenType ?? 'bearer',
      expiresIn: expiresIn,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'created_at': createdAt.toIso8601String(),
    };
  }

  bool get isExpired {
    final expirationDate = createdAt.add(Duration(seconds: expiresIn));
    return DateTime.now()
        .isAfter(expirationDate.subtract(Duration(seconds: 30)));
  }

  bool get needsRefresh {
    final expirationDate = createdAt.add(Duration(seconds: expiresIn));
    return DateTime.now()
        .isAfter(expirationDate.subtract(Duration(minutes: 5)));
  }

  AuthToken copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    DateTime? createdAt,
  }) {
    return AuthToken(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get bearerToken => '$tokenType $accessToken';

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn, createdAt];
}
