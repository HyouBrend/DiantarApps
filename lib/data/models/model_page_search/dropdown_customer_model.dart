import 'package:collection/collection.dart';

class DropdownCustomerModel {
  String? displayName;
  String? kontakID;
  String? type;
  String? latitude;
  String? lokasi;
  String? longitude;

  DropdownCustomerModel({
    this.displayName,
    this.kontakID,
    this.type,
    this.latitude,
    this.lokasi,
    this.longitude,
  });

  DropdownCustomerModel.fromJson(Map<String, dynamic> json) {
    displayName = json['DisplayName'];
    kontakID = json['KontakID'];
    type = json['Type'];
    latitude = json['latitude'];
    lokasi = json['lokasi'];
    longitude = json['longitude'];
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
  String toString() {
    return 'DropdownCustomerModel(displayName: $displayName, kontakID: $kontakID, type: $type, latitude: $latitude, lokasi: $lokasi, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant DropdownCustomerModel other) {
    if (identical(this, other)) return true;
    return other.kontakID == kontakID;
  }

  @override
  int get hashCode {
    return kontakID.hashCode;
  }
}

class CustomerData {
  List<DropdownCustomerModel>? data;

  CustomerData({this.data});

  CustomerData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = (json['data'] as List)
          .map((item) => DropdownCustomerModel.fromJson(item))
          .toList();
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CustomerData(data: $data)';
  }

  @override
  bool operator ==(covariant CustomerData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
