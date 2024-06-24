import 'package:collection/collection.dart';

class DropdownDriveModel {
  final int karyawanID;
  final String nama;
  final String noHP;
  final String posisi;
  final double latitude;
  final double longitude;

  DropdownDriveModel({
    required this.karyawanID,
    required this.nama,
    required this.noHP,
    required this.posisi,
    this.latitude = -6.1819591, // Default latitude kantor
    this.longitude = 106.7763663, // Default longitude kantor
  });

  factory DropdownDriveModel.fromJson(Map<String, dynamic> json) {
    return DropdownDriveModel(
      karyawanID: json['KaryawanID'],
      nama: json['Nama'],
      noHP: json['NoHP'],
      posisi: json['Posisi'],
      latitude: json.containsKey('latitude') ? double.parse(json['latitude']) : -6.1819591,
      longitude: json.containsKey('longitude') ? double.parse(json['longitude']) : 106.7763663,
    );
  }

  @override
  String toString() {
    return 'DropdownDriveModel(karyawanID: $karyawanID, nama: $nama, noHP: $noHP, posisi: $posisi, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant DropdownDriveModel other) {
    if (identical(this, other)) return true;
    return other.karyawanID == karyawanID &&
        other.nama == nama &&
        other.noHP == noHP &&
        other.posisi == posisi &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    return karyawanID.hashCode ^ nama.hashCode ^ noHP.hashCode ^ posisi.hashCode ^ latitude.hashCode ^ longitude.hashCode;
  }
}

class DropdownDriveModelData {
  final List<DropdownDriveModel> data;

  DropdownDriveModelData({
    required this.data,
  });

  factory DropdownDriveModelData.fromJson(Map<String, dynamic> json) {
    return DropdownDriveModelData(
      data: (json['data'] as List).map((item) => DropdownDriveModel.fromJson(item)).toList(),
    );
  }

  @override
  String toString() {
    return 'DropdownDriveModelData(data: $data)';
  }

  @override
  bool operator ==(covariant DropdownDriveModelData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
