
class HistoryPengantaranModel {
  final String createdBy;
  final String? jamPengiriman;
  final String? jamKembali;
  final double minDurasiPengiriman;
  final double minJarakPengiriman;
  final String namaDriver;
  final String nomorPolisiKendaraan;
  final String perjalananId;
  final int shiftKe;
  final String status;
  final String tipeKendaraan;

  HistoryPengantaranModel({
    required this.createdBy,
     this.jamKembali,
     this.jamPengiriman,
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
      createdBy: json['createdBy'],
       jamPengiriman: json['jam_pengiriman'],
      jamKembali: json['jam_kembali'],
       minJarakPengiriman: (json['min_jarak_pengiriman'] is String)
          ? double.parse(json['min_jarak_pengiriman'])
          : json['min_jarak_pengiriman'] ?? 0.0,
      minDurasiPengiriman: (json['min_durasi_pengiriman'] is String)
          ? double.parse(json['min_durasi_pengiriman'])
          : json['min_durasi_pengiriman'] ?? 0.0,
      namaDriver: json['nama_driver'],
      nomorPolisiKendaraan: json['nomor_polisi_kendaraan'],
      perjalananId: json['perjalanan_id'],
      shiftKe: json['shift_ke'],
      status: json['status'],
      tipeKendaraan: json['tipe_kendaraan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdBy': createdBy,
      'jam_kembali': jamKembali,
      'jam_pengiriman': jamPengiriman,
      'min_durasi_pengiriman': minDurasiPengiriman.toString(),
      'min_jarak_pengiriman': minJarakPengiriman.toString(),
      'nama_driver': namaDriver,
      'nomor_polisi_kendaraan': nomorPolisiKendaraan,
      'perjalanan_id': perjalananId,
      'shift_ke': shiftKe,
      'status': status,
      'tipe_kendaraan': tipeKendaraan,
    };
  }
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
