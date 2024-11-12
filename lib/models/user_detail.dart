import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final int id;
  final int userId;
  final String nama;
  final String? tanggalLahir;
  final String? kelamin;
  final String? alamat;
  final String? gambarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserDetail({
    required this.id,
    required this.userId,
    required this.nama,
    this.tanggalLahir,
    this.kelamin,
    this.alamat,
    this.gambarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    return UserDetail(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      nama: json['nama'],
      tanggalLahir: json['tanggal_lahir'],
      kelamin: json['kelamin'],
      alamat: json['alamat'],
      gambarUrl: json['gambarUrl'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'nama': nama,
      'tanggal_lahir': tanggalLahir,
      'kelamin': kelamin,
      'alamat': alamat,
      'gambarUrl': gambarUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        nama,
        tanggalLahir,
        kelamin,
        alamat,
        gambarUrl,
        createdAt,
        updatedAt,
      ];
}
