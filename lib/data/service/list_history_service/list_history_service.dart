import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class ListHistoryService {
  final ApiHelper apiHelper;

  ListHistoryService({required this.apiHelper});

  Future<ListHistoryModelData> getAllHistories() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final response = '''
    {
  "data": [
    {"nama":"nama 1","waktuPesanan":"1996-02-15T03:43:45.519Z","status":"Sudah Dikirim","ID":"1"},
    {"nama":"nama 2","waktuPesanan":"2009-10-19T09:14:11.685Z","status":"Belum Dikirim","ID":"2"},
    {"nama":"nama 3","waktuPesanan":"2084-06-07T00:10:48.621Z","status":"Tidak Dikirim","ID":"3"},
    {"nama":"nama 4","waktuPesanan":"2036-08-29T02:26:07.394Z","status":"Salah Input","ID":"4"},
    {"nama":"nama 5","waktuPesanan":"2086-04-17T19:55:21.888Z","status":"Sudah Dikirim","ID":"5"},
    {"nama":"nama 6","waktuPesanan":"2024-08-19T15:19:13.963Z","status":"Belum Dikirim","ID":"6"},
    {"nama":"nama 7","waktuPesanan":"1992-12-20T23:34:39.614Z","status":"Tidak Dikirim","ID":"7"},
    {"nama":"nama 8","waktuPesanan":"2036-03-03T06:04:43.990Z","status":"Salah Input","ID":"8"},
    {"nama":"nama 9","waktuPesanan":"2018-03-30T01:41:13.019Z","status":"Sudah Dikirim","ID":"9"},
    {"nama":"nama 10","waktuPesanan":"2025-12-04T03:47:03.115Z","status":"Belum Dikirim","ID":"10"},
    {"nama":"nama 11","waktuPesanan":"2055-10-19T05:27:05.559Z","status":"Tidak Dikirim","ID":"11"},
    {"nama":"nama 12","waktuPesanan":"1994-03-18T07:21:41.958Z","status":"Salah Input","ID":"12"},
    {"nama":"nama 13","waktuPesanan":"2097-12-22T05:42:09.825Z","status":"Sudah Dikirim","ID":"13"},
    {"nama":"nama 14","waktuPesanan":"1996-02-15T03:43:45.519Z","status":"Sudah Dikirim","ID":"14"},
    {"nama":"nama 15","waktuPesanan":"2009-10-19T09:14:11.685Z","status":"Belum Dikirim","ID":"15"},
    {"nama":"nama 16","waktuPesanan":"2084-06-07T00:10:48.621Z","status":"Tidak Dikirim","ID":"16"},
    {"nama":"nama 17","waktuPesanan":"2036-08-29T02:26:07.394Z","status":"Salah Input","ID":"17"},
    {"nama":"nama 18","waktuPesanan":"2086-04-17T19:55:21.888Z","status":"Sudah Dikirim","ID":"18"},
    {"nama":"nama 19","waktuPesanan":"2024-08-19T15:19:13.963Z","status":"Belum Dikirim","ID":"19"},
    {"nama":"nama 20","waktuPesanan":"1992-12-20T23:34:39.614Z","status":"Tidak Dikirim","ID":"20"},
    {"nama":"nama 21","waktuPesanan":"2036-03-03T06:04:43.990Z","status":"Salah Input","ID":"21"},
    {"nama":"nama 22","waktuPesanan":"2018-03-30T01:41:13.019Z","status":"Sudah Dikirim","ID":"22"},
    {"nama":"nama 23","waktuPesanan":"2025-12-04T03:47:03.115Z","status":"Belum Dikirim","ID":"23"},
    {"nama":"nama 24","waktuPesanan":"2055-10-19T05:27:05.559Z","status":"Tidak Dikirim","ID":"24"},
    {"nama":"nama 25","waktuPesanan":"1994-03-18T07:21:41.958Z","status":"Salah Input","ID":"25"},
    {"nama":"nama 26","waktuPesanan":"2097-12-22T05:42:09.825Z","status":"Sudah Dikirim","ID":"26"}
    
  ]
}

      ''';

      final result = json.decode(response);
      log('Dummy API response: $result');
      return ListHistoryModelData.fromJson(result);
    } catch (e) {
      log('API error: $e');
      rethrow;
    }
  }
}
