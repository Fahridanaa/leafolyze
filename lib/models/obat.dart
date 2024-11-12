import 'package:equatable/equatable.dart';

class Obat extends Equatable {
  final int id;
  final String gambarUrl;
  final String namaObat;
  final int userId;
  final String deskripsi;
  final String harga;
  final String jenis;

  Obat({
    required this.id,
    required this.gambarUrl,
    required this.namaObat,
    required this.userId,
    required this.deskripsi,
    required this.harga,
    required this.jenis,
  });

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      id: json['id'],
      gambarUrl: json['gambarUrl'],
      namaObat: json['namaObat'],
      userId: json['user_id'],
      deskripsi: json['deskripsi'],
      harga: json['harga'],
      jenis: json['jenis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gambarUrl': gambarUrl,
      'namaObat': namaObat,
      'user_id': userId,
      'deskripsi': deskripsi,
      'harga': harga,
      'jenis': jenis,
    };
  }

  @override
  List<Object?> get props => [
        id,
        gambarUrl,
        namaObat,
        userId,
        deskripsi,
        harga,
        jenis,
      ];
}
