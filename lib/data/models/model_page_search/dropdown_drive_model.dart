import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class DropdownDriveModel extends Equatable {
  final int? karyawanID;
  final String? nama;
  final String? noHP;
  final String? posisi;
  final List<DropdownCustomerModel>? kontaks;
  final String? imageName;

  DropdownDriveModel({
    this.karyawanID,
    this.nama,
    this.noHP,
    this.posisi,
    this.kontaks,
    this.imageName,
  });

  factory DropdownDriveModel.fromJson(Map<String, dynamic> json) {
    return DropdownDriveModel(
      karyawanID: json['KaryawanID'],
      nama: json['Nama'],
      noHP: json['NoHP'],
      posisi: json['Posisi'],
      kontaks: (json['Kontaks'] as List<dynamic>?)
          ?.map(
              (e) => DropdownCustomerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      imageName: json['ImageName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'KaryawanID': karyawanID,
      'Nama': nama,
      'NoHP': noHP,
      'Posisi': posisi,
      'Kontaks': kontaks?.map((e) => e.toJson()).toList(),
      'ImageName': imageName,
    };
  }

  @override
  List<Object?> get props => [karyawanID];

  @override
  String toString() {
    return 'DropdownDriveModel(karyawanID: $karyawanID, nama: $nama, noHP: $noHP, posisi: $posisi, kontaks: $kontaks, imageName: $imageName)';
  }

  @override
  bool operator ==(covariant DropdownDriveModel other) {
    if (identical(this, other)) return true;
    return other.karyawanID == karyawanID;
  }

  @override
  int get hashCode {
    return karyawanID.hashCode;
  }
}

class DropdownDriveModelData {
  final List<DropdownDriveModel> data;

  DropdownDriveModelData({
    required this.data,
  });

  factory DropdownDriveModelData.fromJson(Map<String, dynamic> json) {
    return DropdownDriveModelData(
      data: (json['data'] as List)
          .map((item) => DropdownDriveModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'DropdownDriveModelData(data: $data)';
  }

  @override
  bool operator ==(covariant DropdownDriveModelData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
