class NomorFakturModel {
  String? nomorFaktur;
  String? perjalananId;
  int? shiftKe;
  String? jamPengiriman;
  String? jamKembali;
  int? urutanPengiriman;
  String? driverId;
  String? namaDriver;
  String? kontakId;
  String? inputLatitude;
  String? inputLongitude;
  String? tipeKendaraan;
  String? nomorPolisiKendaraan;
  String? pointLatLong;
  String? googleMapUrl;

  NomorFakturModel({
    this.nomorFaktur,
    this.perjalananId,
    this.shiftKe,
    this.jamPengiriman,
    this.jamKembali,
    this.urutanPengiriman,
    this.driverId,
    this.namaDriver,
    this.kontakId,
    this.inputLatitude,
    this.inputLongitude,
    this.tipeKendaraan,
    this.nomorPolisiKendaraan,
    this.pointLatLong,
    this.googleMapUrl,
  });

  NomorFakturModel.fromJson(Map<String, dynamic> json) {
    nomorFaktur = json['nomorFaktur'];
    perjalananId = json['perjalananId'];
    shiftKe = json['shiftKe'];
    jamPengiriman = json['jamPengiriman'];
    jamKembali = json['jamKembali'];
    urutanPengiriman = json['urutanPengiriman'];
    driverId = json['driverId'];
    namaDriver = json['namaDriver'];
    kontakId = json['kontakId'];
    inputLatitude = json['inputLatitude'];
    inputLongitude = json['inputLongitude'];
    tipeKendaraan = json['tipeKendaraan'];
    nomorPolisiKendaraan = json['nomorPolisiKendaraan'];
    pointLatLong = json['pointLatLong'];
    googleMapUrl = json['googleMapUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nomorFaktur': nomorFaktur,
      'perjalananId': perjalananId,
      'shiftKe': shiftKe,
      'jamPengiriman': jamPengiriman,
      'jamKembali': jamKembali,
      'urutanPengiriman': urutanPengiriman,
      'driverId': driverId,
      'namaDriver': namaDriver,
      'kontakId': kontakId,
      'inputLatitude': inputLatitude,
      'inputLongitude': inputLongitude,
      'tipeKendaraan': tipeKendaraan,
      'nomorPolisiKendaraan': nomorPolisiKendaraan,
      'pointLatLong': pointLatLong,
      'googleMapUrl': googleMapUrl,
    };
  }
}
