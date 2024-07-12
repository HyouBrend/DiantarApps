import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class HistoryPengantaranService {
  final ApiHelper apiHelper;

  HistoryPengantaranService({required this.apiHelper});

  Future<HistoryPengantaranModelData> getAllHistories() async {
    try {
      final response = await apiHelper.get(url: APIJarakLocal.historyPengantaran);
      print('Response: ${response.data}');
      return HistoryPengantaranModelData.fromJson(response.data);
    } catch (e) {
      print('Error fetching history pengantaran: $e');
      rethrow;
    }
  }
}
