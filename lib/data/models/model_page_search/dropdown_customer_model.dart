import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';
import 'package:equatable/equatable.dart';

class DropdownCustomerModel extends Equatable {
  final String? displayName;
  final String? kontakID;
  final String? type;
  final String? latitude;
  final String? lokasi;
  final String? longitude;
  final String? nomorFaktur;
  final int? urutanPengiriman;

  DropdownCustomerModel({
    this.displayName,
    this.kontakID,
    this.type,
    this.latitude,
    this.lokasi,
    this.longitude,
    this.nomorFaktur,
    this.urutanPengiriman,
  });

  factory DropdownCustomerModel.fromJson(Map<String, dynamic> json) {
    return DropdownCustomerModel(
      displayName: json['DisplayName'],
      kontakID: json['KontakID'],
      type: json['Type'],
      latitude: json['latitude'],
      lokasi: json['lokasi'],
      longitude: json['longitude'],
      nomorFaktur: json['nomor_faktur'],
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

  factory DropdownCustomerModel.fromKontak(KontakModel kontak) {
    return DropdownCustomerModel(
      displayName: kontak.displayName,
      kontakID: kontak.kontakID,
      type: kontak.type,
      latitude: kontak.latitude,
      lokasi: kontak.lokasi,
      longitude: kontak.longitude,
      nomorFaktur: kontak.nomorFaktur,
      urutanPengiriman: kontak.urutanPengiriman,
    );
  }

  KontakModel toKontak() {
    return KontakModel(
      displayName: displayName ?? '',
      kontakID: kontakID ?? '',
      type: type ?? '',
      latitude: latitude ?? '',
      lokasi: lokasi ?? '',
      longitude: longitude ?? '',
      nomorFaktur: nomorFaktur ?? '',
      urutanPengiriman: urutanPengiriman ?? 0,
    );
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

class CustomerData {
  final List<DropdownCustomerModel>? data;

  CustomerData({this.data});

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DropdownCustomerModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [data];

  @override
  String toString() {
    return 'CustomerData(data: $data)';
  }
}
