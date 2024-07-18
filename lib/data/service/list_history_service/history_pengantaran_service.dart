import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class HistoryPengantaranService {
  final ApiHelper apiHelper;

  HistoryPengantaranService({required this.apiHelper});

  Future<HistoryPengantaranModelData> getAllHistories() async {
    try {
      final response =
          await apiHelper.get(url: APIJarakLocal.historyPengantaran);
      print('Response: ${response.data}');

      // Periksa dan ubah nilai default dalam response.data
      Map<String, dynamic> data = response.data;
      data['data'] = (data['data'] as List).map((item) {
        if (item['jam_kembali'] == "Mon, 01 Jan 1900 00:00:00 GMT") {
          item['jam_kembali'] = "Yok Di Update!!";
        }
        if (item['jam_pengiriman'] == "Mon, 01 Jan 1900 00:00:00 GMT") {
          item['jam_pengiriman'] = "Yok Di Update!!";
        }
        return item;
      }).toList();

      return HistoryPengantaranModelData.fromJson(data);
    } catch (e) {
      print('Error fetching history pengantaran: $e');
      rethrow;
    }
  }
}
