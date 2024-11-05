import 'package:diantar_jarak/util/format_date.dart';

class HistoryPengantaranModel {
  final String createdAt;
  final String createdBy;
  final String jamPengiriman;
  final String jamKembali;
  final double minDurasiPengiriman;
  final double minJarakPengiriman;
  final String namaDriver;
  final String nomorPolisiKendaraan;
  final String perjalananId;
  final int shiftKe;
  final String status;
  final String tipeKendaraan;

  HistoryPengantaranModel({
    required this.createdAt,
    required this.createdBy,
    required this.jamKembali,
    required this.jamPengiriman,
    required this.minDurasiPengiriman,
    required this.minJarakPengiriman,
    required this.namaDriver,
    required this.nomorPolisiKendaraan,
    required this.perjalananId,
    required this.shiftKe,
    required this.status,
    required this.tipeKendaraan,
  });

  factory HistoryPengantaranModel.fromJson(Map<String, dynamic> json) {
    return HistoryPengantaranModel(
      createdAt: json['CreatedAt'] ?? '',
      createdBy: json['CreatedBy'] ?? '',
      jamKembali: _validateAndFormatTime(json['JamKembali']),
      jamPengiriman: _validateAndFormatTime(json['JamPengiriman']),
      minJarakPengiriman: _parseDouble(json['MinJarakPengiriman']),
      minDurasiPengiriman: _parseDouble(json['MinDurasiPengiriman']),
      namaDriver: json['NamaDriver'] ?? '',
      nomorPolisiKendaraan: json['NomorPolisiKendaraan'] ?? '',
      perjalananId: json['PerjalananID'] ?? '',
      shiftKe: json['ShiftKe'] ?? 0,
      status: json['Status'] ?? '',
      tipeKendaraan: json['TipeKendaraan'] ?? '',
    );
  }

  static String _validateAndFormatTime(String? timeStr) {
    const invalidDate = 'Mon, 01 Jan 1900 00:00:00 GMT';
    if (timeStr == null || timeStr.isEmpty || timeStr == invalidDate) {
      return 'Perlu di update';
    }
    return formatTimeBakAndSend(timeStr) ?? 'Perlu di update';
  }

  static double _parseDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is double) {
      return value;
    }
    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatedAt': createdAt,
      'CreatedBy': createdBy,
      'JamKembali': jamKembali,
      'JamPengiriman': jamPengiriman,
      'MinDurasiPengiriman': minDurasiPengiriman.toString(),
      'MinJarakPengiriman': minJarakPengiriman.toString(),
      'NamaDriver': namaDriver,
      'NomorPolisiKendaraan': nomorPolisiKendaraan,
      'PerjalananID': perjalananId,
      'ShiftKe': shiftKe,
      'Status': status,
      'TipeKendaraan': tipeKendaraan,
    };
  }
}
