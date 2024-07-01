import 'package:equatable/equatable.dart';

class DropdownCustomerModel extends Equatable {
  final String? displayName;
  final String? kontakID;
  final String? type;
  final String? latitude;
  final String? lokasi;
  final String? longitude;

  DropdownCustomerModel({
    this.displayName,
    this.kontakID,
    this.type,
    this.latitude,
    this.lokasi,
    this.longitude,
  });

  factory DropdownCustomerModel.fromJson(Map<String, dynamic> json) {
    return DropdownCustomerModel(
      displayName: json['DisplayName'],
      kontakID: json['KontakID'],
      type: json['Type'],
      latitude: json['latitude'],
      lokasi: json['lokasi'],
      longitude: json['longitude'],
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
    };
  }

  @override
  List<Object?> get props => [kontakID];

  @override
  String toString() {
    return 'DropdownCustomerModel(displayName: $displayName, kontakID: $kontakID, type: $type, latitude: $latitude, lokasi: $lokasi, longitude: $longitude)';
  }
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
