import 'package:diantar_jarak/data/models/model_page_search/kontak_model.dart';
import 'package:equatable/equatable.dart';

class KontakModel extends Equatable {
  final String displayName;
  final String kontakID;
  final String type;
  final String latitude;
  final String lokasi;
  final String longitude;
  final String nomorFaktur;
  final int urutanPengiriman;

  KontakModel({
    required this.displayName,
    required this.kontakID,
    required this.type,
    required this.latitude,
    required this.lokasi,
    required this.longitude,
    required this.nomorFaktur,
    required this.urutanPengiriman,
  });

  factory KontakModel.fromJson(Map<String, dynamic> json) {
    return KontakModel(
      displayName: json['DisplayName'],
      kontakID: json['KontakID'],
      type: json['Type'] ?? '',
      latitude: json['latitude'],
      lokasi: json['lokasi'],
      longitude: json['longitude'],
      nomorFaktur: json['nomor_faktur'] ?? '',
      urutanPengiriman: json['urutan_pengiriman'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DisplayName': displayName,
      'KontakID': kontakID,
      'Type': type,
      'latitude': latitude,
      'lokasi': lokasi,
      'longitude': longitude,
      'nomor_faktur': nomorFaktur,
      'urutan_pengiriman': urutanPengiriman,
    };
  }

  @override
  List<Object?> get props => [
        displayName,
        kontakID,
        type,
        latitude,
        lokasi,
        longitude,
        nomorFaktur,
        urutanPengiriman,
      ];
}

class DetailPengantaranModel {
  final String googleMapsUrl;
  final int shiftKe;
  final String jamPengiriman;
  final String jamKembali;
  final int driverId;
  final String namaDriver;
  final String tipeKendaraan;
  final String nomorPolisiKendaraan;
  final String createdBy;
  final List<KontakModel> kontaks;
  final double minDistance;
  final double minDuration;

  DetailPengantaranModel({
    required this.googleMapsUrl,
    required this.shiftKe,
    required this.jamPengiriman,
    required this.jamKembali,
    required this.driverId,
    required this.namaDriver,
    required this.tipeKendaraan,
    required this.nomorPolisiKendaraan,
    required this.createdBy,
    required this.kontaks,
    required this.minDistance,
    required this.minDuration,
  });

  factory DetailPengantaranModel.fromJson(Map<String, dynamic> json) {
    return DetailPengantaranModel(
      googleMapsUrl: json['google_maps_url'] ?? '',
      shiftKe: json['shift_ke'] ?? 0,
      jamPengiriman: json['jam_pengiriman'] ?? '',
      jamKembali: json['jam_kembali'] ?? '',
      driverId: json['driver_id'] ?? 0,
      namaDriver: json['nama_driver'] ?? '',
      tipeKendaraan: json['tipe_kendaraan'] ?? '',
      nomorPolisiKendaraan: json['nomor_polisi_kendaraan'] ?? '',
      createdBy: json['created_by'] ?? '',
      kontaks: (json['kontaks'] as List<dynamic>?)
              ?.map((item) => KontakModel.fromJson(item))
              .toList() ??
          [], // Inisialisasi dengan daftar kosong jika null
      minDistance: json['min_distance'] ?? 0.0,
      minDuration: json['min_duration'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'google_maps_url': googleMapsUrl,
      'shift_ke': shiftKe,
      'jam_pengiriman': jamPengiriman,
      'jam_kembali': jamKembali,
      'driver_id': driverId,
      'nama_driver': namaDriver,
      'tipe_kendaraan': tipeKendaraan,
      'nomor_polisi_kendaraan': nomorPolisiKendaraan,
      'created_by': createdBy,
      'kontaks': kontaks.map((item) => item.toJson()).toList(),
      'min_distance': minDistance,
      'min_duration': minDuration,
    };
  }
}
