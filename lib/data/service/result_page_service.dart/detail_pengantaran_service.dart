import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class DetailPengantaranRepository {
  final ApiHelper apiHelper;

  DetailPengantaranRepository({required this.apiHelper});

  Future<DetailPengantaran> fetchDetailPengantaran() async {
    final response = await apiHelper.get(url: APIJarakLocal.listCustomers);
    return DetailPengantaran.fromJson(response.data);
  }

  Future<String> submitPengantaran(DetailPengantaran detailPengantaran) async {
    final response = await apiHelper.post(
      url: APIJarakLocal.submitPengantaran,
      body: detailPengantaran.toJson(),
    );
    return response.data['message'];
  }
}
