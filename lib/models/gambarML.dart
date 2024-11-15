import 'package:equatable/equatable.dart';

class GambarML extends Equatable {
  final String gambarUrl;
  final int userId;
  final String deskripsi;

  GambarML({
    required this.gambarUrl,
    required this.userId,
    required this.deskripsi,
  });

  factory GambarML.fromJson(Map<String, dynamic> json) {
    return GambarML(
      gambarUrl: json['gambarUrl'],
      userId: json['user_id'],
      deskripsi: json['deskripsi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gambarUrl': gambarUrl,
      'user_id': userId,
      'deskripsi': deskripsi,
    };
  }

  @override
  List<Object?> get props => [
        gambarUrl,
        userId,
        deskripsi,
      ];
}
