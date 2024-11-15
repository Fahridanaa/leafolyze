import 'package:equatable/equatable.dart';

class Artikel extends Equatable {
  final int id;
  final int userId;
  final String judul;
  final String konten;
  final String gambarUrl;
  final int durasiBaca;

  Artikel({
    required this.id,
    required this.userId,
    required this.judul,
    required this.konten,
    required this.gambarUrl,
    required this.durasiBaca,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      id: json['id'],
      userId: json['user_id'],
      judul: json['judul'],
      konten: json['konten'],
      gambarUrl: json['gambarUrl'],
      durasiBaca: json['durasi_baca'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'judul': judul,
      'konten': konten,
      'gambarUrl': gambarUrl,
      'durasi_baca': durasiBaca,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        judul,
        konten,
        gambarUrl,
        durasiBaca,
      ];
}
