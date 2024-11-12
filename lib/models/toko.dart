import 'package:equatable/equatable.dart';

class Toko extends Equatable {
  final int id;
  final int userId;
  final String namaToko;
  final String alamat;
  final String deskripsi;
  final String jamOperasional;
  final String gambarUrl;

  Toko({
    required this.id,
    required this.userId,
    required this.namaToko,
    required this.alamat,
    required this.deskripsi,
    required this.jamOperasional,
    required this.gambarUrl,
  });

  factory Toko.fromJson(Map<String, dynamic> json) {
    return Toko(
      id: json['id'],
      userId: json['user_id'],
      namaToko: json['nama_toko'],
      alamat: json['alamat'],
      deskripsi: json['deskripsi'],
      jamOperasional: json['jam_operasional'],
      gambarUrl: json['gambarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'nama_toko': namaToko,
      'alamat': alamat,
      'deskripsi': deskripsi,
      'jam_operasional': jamOperasional,
      'gambarUrl': gambarUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        namaToko,
        alamat,
        deskripsi,
        jamOperasional,
        gambarUrl,
      ];
}
