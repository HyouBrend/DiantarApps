import 'package:equatable/equatable.dart';

class HistoryPengantaranModel extends Equatable {
  final String perjalananId;
  final int shiftKe;
  final String? jamPengiriman;
  final String? jamKembali;
  final String namaDriver;
  final String tipeKendaraan;
  final String nomorPolisiKendaraan;
  final double minJarakPengiriman;
  final double minDurasiPengiriman;
  final String createdBy;

  HistoryPengantaranModel({
    required this.perjalananId,
    required this.shiftKe,
    this.jamPengiriman,
    this.jamKembali,
    required this.namaDriver,
    required this.tipeKendaraan,
    required this.nomorPolisiKendaraan,
    required this.minJarakPengiriman,
    required this.minDurasiPengiriman,
    required this.createdBy,
  });

  factory HistoryPengantaranModel.fromJson(Map<String, dynamic> json) {
    return HistoryPengantaranModel(
      perjalananId: json['perjalanan_id'] ?? '',
      shiftKe: json['shift_ke'] ?? 0,
      jamPengiriman: json['jam_pengiriman'],
      jamKembali: json['jam_kembali'],
      namaDriver: json['nama_driver'] ?? '',
      tipeKendaraan: json['tipe_kendaraan'] ?? '',
      nomorPolisiKendaraan: json['nomor_polisi_kendaraan'] ?? '',
      minJarakPengiriman: (json['min_jarak_pengiriman'] is String)
          ? double.parse(json['min_jarak_pengiriman'])
          : json['min_jarak_pengiriman'] ?? 0.0,
      minDurasiPengiriman: (json['min_durasi_pengiriman'] is String)
          ? double.parse(json['min_durasi_pengiriman'])
          : json['min_durasi_pengiriman'] ?? 0.0,
      createdBy: json['createdBy'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'perjalanan_id': perjalananId,
      'shift_ke': shiftKe,
      'jam_pengiriman': jamPengiriman,
      'jam_kembali': jamKembali,
      'nama_driver': namaDriver,
      'tipe_kendaraan': tipeKendaraan,
      'nomor_polisi_kendaraan': nomorPolisiKendaraan,
      'min_jarak_pengiriman': minJarakPengiriman,
      'min_durasi_pengiriman': minDurasiPengiriman,
      'createdBy': createdBy,
    };
  }

  @override
  List<Object?> get props => [
        perjalananId,
        shiftKe,
        jamPengiriman,
        jamKembali,
        namaDriver,
        tipeKendaraan,
        nomorPolisiKendaraan,
        minJarakPengiriman,
        minDurasiPengiriman,
        createdBy,
      ];
}

class HistoryPengantaranModelData {
  final List<HistoryPengantaranModel> data;

  HistoryPengantaranModelData({required this.data});

  factory HistoryPengantaranModelData.fromJson(Map<String, dynamic> json) {
    return HistoryPengantaranModelData(
      data: (json['data'] as List)
          .map((item) => HistoryPengantaranModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
