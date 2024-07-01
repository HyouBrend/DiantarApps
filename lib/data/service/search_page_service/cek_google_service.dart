import 'package:diantar_jarak/data/models/model_page_search/cek_google_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class CekGoogleService {
  final ApiHelper apiHelper;

  CekGoogleService({required this.apiHelper});

  Future<Map<String, dynamic>> cekGoogle(CekGoogleModel model) async {
    try {
      final result = await apiHelper.post(
        url: APIJarakLocal.CekGoogle,
        body: model.toJson(),
      );
      return result;
    } catch (e) {
      throw Exception('Failed to cek google: $e');
    }
  }
}
