import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:dio/dio.dart';
import 'package:diantar_jarak/data/models/model_history_page/model_detail_pengantaran_page.dart';

class DetailPengantaranService {
  final ApiHelper apiHelper;

  DetailPengantaranService({required this.apiHelper});

  Future<List<DetailPengantaran>> fetchDetailPengantaran(
      String perjalananID) async {
    final String url = '${APIJarakLocal.detailPengantaran}/$perjalananID';

    try {
      Response response = await apiHelper.get(url: url);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];

        // Periksa dan ubah nilai default dalam response.data
        data = data.map((item) {
          if (item['jam_kembali'] == "Mon, 01 Jan 1900 00:00:00 GMT" ||
              item['jam_kembali'] == null) {
            item['jam_kembali'] = "Yok Di Update!!";
          }
          if (item['jam_pengiriman'] == "Mon, 01 Jan 1900 00:00:00 GMT" ||
              item['jam_pengiriman'] == null) {
            item['jam_pengiriman'] = "Yok Di Update!!";
          }
          return item;
        }).toList();

        return data.map((item) => DetailPengantaran.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load detail pengantaran');
      }
    } catch (e) {
      print('Error fetching detail pengantaran: $e');
      rethrow;
    }
  }
}
