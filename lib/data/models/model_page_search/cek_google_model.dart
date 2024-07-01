import 'package:equatable/equatable.dart';

class CekGoogleModel extends Equatable {
  final int karyawanID;
  final String nama;
  final String posisi;
  final String noHP;
  final List<KontakModel> kontaks;

  CekGoogleModel({
    required this.karyawanID,
    required this.nama,
    required this.posisi,
    required this.noHP,
    required this.kontaks,
  });

  Map<String, dynamic> toJson() {
    return {
      'KaryawanID': karyawanID,
      'Nama': nama,
      'Posisi': posisi,
      'NoHP': noHP,
      'Kontaks': kontaks.map((kontak) => kontak.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [karyawanID, nama, posisi, noHP, kontaks];
}

class KontakModel extends Equatable {
  final String kontakID;
  final String displayName;
  final String type;
  final String lokasi;
  final String latitude;
  final String longitude;

  KontakModel({
    required this.kontakID,
    required this.displayName,
    required this.type,
    required this.lokasi,
    required this.latitude,
    required this.longitude,
  });

  factory KontakModel.fromJson(Map<String, dynamic> json) {
    return KontakModel(
      kontakID: json['KontakID'],
      displayName: json['DisplayName'],
      type: json['Type'],
      lokasi: json['lokasi'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'KontakID': kontakID,
      'DisplayName': displayName,
      'Type': type,
      'lokasi': lokasi,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  List<Object?> get props =>
      [kontakID, displayName, type, lokasi, latitude, longitude];
}
