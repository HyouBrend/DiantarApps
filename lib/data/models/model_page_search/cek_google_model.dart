import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';

class CekGoogleResult {
  final String googleMapsUrl;
  final List<KontakModel> kontaks;
  final double minDistance;
  final double minDuration;

  CekGoogleResult({
    required this.googleMapsUrl,
    required this.kontaks,
    required this.minDistance,
    required this.minDuration,
  });

  factory CekGoogleResult.fromJson(Map<String, dynamic> json) {
    return CekGoogleResult(
      googleMapsUrl: json['data']['google_maps_url'],
      kontaks: (json['data']['kontaks'] as List<dynamic>)
          .map((item) => KontakModel.fromJson(item))
          .toList(),
      minDistance: json['data']['min_distance'],
      minDuration: json['data']['min_duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'google_maps_url': googleMapsUrl,
        'kontaks': kontaks.map((item) => item.toJson()).toList(),
        'min_distance': minDistance,
        'min_duration': minDuration,
      },
    };
  }
}
