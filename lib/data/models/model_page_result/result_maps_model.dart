import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';

class MapsResultsModel {
  String? displayName;
  String? kontakID;
  String? pointLatLong;

  MapsResultsModel({
    this.displayName,
    this.kontakID,
    this.pointLatLong,
  });

  MapsResultsModel.fromDropdownCustomerModel(DropdownCustomerModel customer)
      : displayName = customer.displayName,
        kontakID = customer.kontakID,
        pointLatLong = '${customer.latitude},${customer.longitude}';

  MapsResultsModel.fromJson(Map<String, dynamic> json) {
    displayName = json['DisplayName'];
    kontakID = json['KontakID'];
    pointLatLong = json['PointLatLong'];
  }

  get nomorFaktur => null;

  get perjalananId => null;

  get shiftKe => null;

  get jamPengiriman => null;

  get jamKembali => null;

  get urutanPengiriman => null;

  get driverId => null;

  get namaDriver => null;

  get kontakId => null;

  get inputLatitude => null;

  get inputLongitude => null;

  get tipeKendaraan => null;

  get nomorPolisiKendaraan => null;

  get googleMapUrl => null;

  Map<String, dynamic> toJson() {
    return {
      'DisplayName': displayName,
      'KontakID': kontakID,
      'PointLatLong': pointLatLong,
    };
  }

  @override
  String toString() {
    return 'MapsResultsModel(displayName: $displayName, kontakID: $kontakID, pointLatLong: $pointLatLong)';
  }

  @override
  bool operator ==(covariant MapsResultsModel other) {
    if (identical(this, other)) return true;
    return other.kontakID == kontakID;
  }

  @override
  int get hashCode {
    return kontakID.hashCode;
  }
}
