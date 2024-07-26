import 'package:diantar_jarak/util/format_date.dart';

class UpdateDetailPengantaran {
  final int pengantaranId;
  final int nomorFaktur;
  final int shiftKe;
  final String jamPengiriman;
  final String jamKembali;
  final int urutanPengiriman;
  final int driverId;
  final String namaDriver;
  final String tipeKendaraan;
  final String nomorPolisiKendaraan;
  final String updateBy;

  UpdateDetailPengantaran({
    required this.pengantaranId,
    required this.nomorFaktur,
    required this.shiftKe,
    required this.jamPengiriman,
    required this.jamKembali,
    required this.urutanPengiriman,
    required this.driverId,
    required this.namaDriver,
    required this.tipeKendaraan,
    required this.nomorPolisiKendaraan,
    required this.updateBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'pengantaran_id': pengantaranId,
      'nomor_faktur': nomorFaktur,
      'shift_ke': shiftKe,
      'jam_pengiriman': formatDisplayDate(jamPengiriman),
      'jam_kembali': formatDisplayDate(jamKembali),
      'urutan_pengiriman': urutanPengiriman,
      'driver_id': driverId,
      'nama_driver': namaDriver,
      'tipe_kendaraan': tipeKendaraan,
      'nomor_polisi_kendaraan': nomorPolisiKendaraan,
      'update_by': updateBy,
    };
  }
}
