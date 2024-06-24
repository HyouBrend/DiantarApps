import 'package:collection/collection.dart';

class ListHistoryModel {
  final String nama;
  final String waktuPesanan;
  final String status; // Add status field

  ListHistoryModel({
    required this.nama,
    required this.waktuPesanan,
    required this.status, // Add status to the constructor
  });

  factory ListHistoryModel.fromJson(Map<String, dynamic> json) {
    return ListHistoryModel(
      nama: json['nama'],
      waktuPesanan: json['waktuPesanan'],
      status: json['status'], // Parse status from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'waktuPesanan': waktuPesanan,
      'status': status, // Include status in JSON
    };
  }

  @override
  String toString() {
    return 'ListHistoryModel(nama: $nama, waktuPesanan: $waktuPesanan, status: $status)';
  }

  @override
  bool operator ==(covariant ListHistoryModel other) {
    if (identical(this, other)) return true;
    return other.nama == nama &&
        other.waktuPesanan == waktuPesanan &&
        other.status == status;
  }

  @override
  int get hashCode {
    return nama.hashCode ^ waktuPesanan.hashCode ^ status.hashCode;
  }
}

class ListHistoryModelData {
  final List<ListHistoryModel> data;

  ListHistoryModelData({
    required this.data,
  });

  factory ListHistoryModelData.fromJson(Map<String, dynamic> json) {
    return ListHistoryModelData(
      data: (json['data'] as List)
          .map((item) => ListHistoryModel.fromJson(item))
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
    return 'ListHistoryModelData(data: $data)';
  }

  @override
  bool operator ==(covariant ListHistoryModelData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
