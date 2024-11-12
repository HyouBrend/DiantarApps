import 'package:diantar_jarak/data/models/history_perjalanan_model/history_pengantaran_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class HistoryPengantaranService {
  final ApiHelper apiHelper;

  HistoryPengantaranService({required this.apiHelper});

  Future<HistoryPengantaranResponse> getHistoryPengantaran({
    required int page,
    required int pageSize,
    required Map<String, String?> filters, // Nullable filters
  }) async {
    try {
      // Siapkan body request dengan nilai default ""
      final Map<String, dynamic> body = {
        'nama_driver': filters['nama_driver'] ?? '',
        'created_by': filters['created_by'] ?? '',
        'status': filters['status'] ?? '',
        'timeline': filters['timeline'] ?? '', // Tambahkan timelin
        'start_date': filters['start_date'] ?? '',
        'end_date': filters['end_date'] ?? '',
      };

      // Panggil API dengan POST
      final response = await apiHelper.post(
        url: APIJarakLocal.historyPengantaran,
        body: body,
        queryParameters: {
          'page': page.toString(),
          'page_size': pageSize.toString(),
          ...filters,
        },
      );

      // Validasi respons dan cek apakah data ada
      if (response.data == null || response.data['data'] is! List) {
        throw Exception("Invalid API response");
      }

      // Transformasi data jika diperlukan
      List dataList = _transformData(response.data['data']);

      // Buat ulang respons dengan data yang dimodifikasi
      response.data['data'] = dataList;

      // Parsing respons menjadi model
      return HistoryPengantaranResponse.fromJson(response.data);
    } catch (e) {
      // Log error untuk debugging
      print("Error fetching history: $e");
      rethrow; // Rethrow agar error bisa ditangani di tempat lain
    }
  }

  // Helper untuk memodifikasi data jika tanggal default ditemukan
  List _transformData(List data) {
    return data.map((item) {
      item['jam_kembali'] =
          item['jam_kembali'] == "Mon, 01 Jan 1900 00:00:00 GMT"
              ? "Yok Di Update!!"
              : item['jam_kembali'];

      item['jam_pengiriman'] =
          item['jam_pengiriman'] == "Mon, 01 Jan 1900 00:00:00 GMT"
              ? "Yok Di Update!!"
              : item['jam_pengiriman'];

      return item;
    }).toList();
  }
}
