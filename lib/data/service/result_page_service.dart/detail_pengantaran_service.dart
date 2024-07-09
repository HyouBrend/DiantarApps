// detail_pengantaran_service.dart
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';

class SubmitPengantaranService {
  final ApiHelper apiHelper;

  SubmitPengantaranService({required this.apiHelper});

  Future<DetailPengantaranModel> submitPengantaran(
      DetailPengantaranModel detailPengantaran) async {
    final response = await apiHelper.post(
      url: APIJarakLocal.submitPengantaran,
      body: detailPengantaran.toJson(),
    );
    return DetailPengantaranModel.fromJson(response.data);
  }
}
