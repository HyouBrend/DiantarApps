import 'package:diantar_jarak/util/format_date.dart';

class DetailPengantaran {
  final String googleMapsURL;
  final String inputLatitude;
  final String inputLongitude;
  final String kontakID;
  final String createdBy;
  final String createdDate;
  final String displayName;
  final int driverID;
  final String jamKembali;
  final String jamPengiriman;
  final String lokasi;
  final double minDurasiPengiriman;
  final double minJarakPengiriman;
  final String namaDriver;
  final String noHp;
  final int nomorFaktur;
  final String nomorPolisiKendaraan;
  final int pengantaranID;
  final String perjalananID;
  final String posisi;
  final int shiftKe;
  final String tipeKendaraan;
  final String updateAt;
  final String updateBy;
  final int urutanPengiriman;

  DetailPengantaran({
    required this.googleMapsURL,
    required this.inputLatitude,
    required this.inputLongitude,
    required this.kontakID,
    required this.createdBy,
    required this.createdDate,
    required this.displayName,
    required this.driverID,
    required this.jamKembali,
    required this.jamPengiriman,
    required this.lokasi,
    required this.minDurasiPengiriman,
    required this.minJarakPengiriman,
    required this.namaDriver,
    required this.noHp,
    required this.nomorFaktur,
    required this.nomorPolisiKendaraan,
    required this.pengantaranID,
    required this.perjalananID,
    required this.posisi,
    required this.shiftKe,
    required this.tipeKendaraan,
    required this.updateAt,
    required this.updateBy,
    required this.urutanPengiriman,
  });

  factory DetailPengantaran.fromJson(Map<String, dynamic> json) {
    return DetailPengantaran(
      googleMapsURL: json['GoogleMapsURL'],
      inputLatitude: json['Input_latitude'],
      inputLongitude: json['Input_longitude'],
      kontakID: json['KontakID'],
      createdBy: json['created_by'],
      createdDate: formatDate(json['created_date']) ?? '',
      displayName: json['display_name'],
      driverID: json['driver_id'],
      jamKembali: formatDate(json['jam_kembali']) ?? '',
      jamPengiriman: formatDate(json['jam_pengiriman']) ?? '',
      lokasi: json['lokasi'],
      minDurasiPengiriman: double.parse(json['min_durasi_pengiriman']),
      minJarakPengiriman: double.parse(json['min_jarak_pengiriman']),
      namaDriver: json['nama_driver'],
      noHp: json['no_hp'],
      nomorFaktur: json['nomor_faktur'],
      nomorPolisiKendaraan: json['nomor_polisi_kendaraan'],
      pengantaranID: json['pengantaran_id'],
      perjalananID: json['perjalanan_id'],
      posisi: json['posisi'],
      shiftKe: json['shift_ke'],
      tipeKendaraan: json['tipe_kendaraan'],
      updateAt: formatDate(json['update_at']) ?? '',
      updateBy: json['update_by'],
      urutanPengiriman: json['urutan_pengiriman'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GoogleMapsURL': googleMapsURL,
      'Input_latitude': inputLatitude,
      'Input_longitude': inputLongitude,
      'KontakID': kontakID,
      'created_by': createdBy,
      'created_date': createdDate,
      'display_name': displayName,
      'driver_id': driverID,
      'jam_kembali': jamKembali,
      'jam_pengiriman': jamPengiriman,
      'lokasi': lokasi,
      'min_durasi_pengiriman': minDurasiPengiriman.toString(),
      'min_jarak_pengiriman': minJarakPengiriman.toString(),
      'nama_driver': namaDriver,
      'no_hp': noHp,
      'nomor_faktur': nomorFaktur,
      'nomor_polisi_kendaraan': nomorPolisiKendaraan,
      'pengantaran_id': pengantaranID,
      'perjalanan_id': perjalananID,
      'posisi': posisi,
      'shift_ke': shiftKe,
      'tipe_kendaraan': tipeKendaraan,
      'update_at': updateAt,
      'update_by': updateBy,
      'urutan_pengiriman': urutanPengiriman,
    };
  }
}
