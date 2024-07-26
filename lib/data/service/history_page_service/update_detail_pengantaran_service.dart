import 'package:diantar_jarak/data/models/model_history_page/model_update_detail_pengantaran_page.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class UpdateDetailPengantaranService {
  final ApiHelper apiHelper;

  UpdateDetailPengantaranService({required this.apiHelper});

  Future<void> submitPengantaran(UpdateDetailPengantaran pengantaran) async {
    try {
      final response = await apiHelper.post(
        url: 'http://192.168.18.7:5002/update_detail_pengantaran',
        body: {
          'kontaks': [pengantaran.toJson()],
        },
      );
      if (response.statusCode == 200) {
        print('Update Berhasil!');
      } else {
        print('Gagal Update: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
