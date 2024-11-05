import 'package:diantar_jarak/data/models/history_perjalanan_model/history_perjalanan_model.dart';
import 'pagination_model.dart';

class HistoryPengantaranResponse {
  final List<HistoryPengantaranModel> data;
  final Pagination pagination;
  final double? totalJarakKeseluruhan;

  HistoryPengantaranResponse({
    required this.data,
    required this.pagination,
    this.totalJarakKeseluruhan,
  });

  factory HistoryPengantaranResponse.fromJson(Map<String, dynamic> json) {
    return HistoryPengantaranResponse(
      data: (json['data'] as List)
          .map((item) => HistoryPengantaranModel.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
      totalJarakKeseluruhan:
          (json['total_jarak_keseluruhan'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
      'total_jarak_keseluruhan': totalJarakKeseluruhan,
    };
  }

  @override
  String toString() {
    return 'HistoryPengantaranResponse(data: $data, pagination: $pagination, totalJarakKeseluruhan: $totalJarakKeseluruhan)';
  }
}
