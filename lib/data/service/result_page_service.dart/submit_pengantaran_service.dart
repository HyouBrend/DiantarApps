import 'package:diantar_jarak/data/models/model_page_result/submit_pengantaran_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class SubmitPengantaranService {
  final ApiHelper apiHelper;

  SubmitPengantaranService({required this.apiHelper});

  Future<SubmitPengantaranModel> fetchDetailPengantaran() async {
    final response = await apiHelper.get(url: APIJarakLocal.listCustomers);
    return SubmitPengantaranModel.fromJson(response.data);
  }

  Future<String> submitPengantaran(
      SubmitPengantaranModel SubmitPengantaranModel) async {
    final response = await apiHelper.post(
      url: APIJarakLocal.submitPengantaran,
      body: SubmitPengantaranModel.toJson(),
    );
    return response.data['message'];
  }
}
