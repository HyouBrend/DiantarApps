import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// Class untuk memuat konfigurasi dari file JSON
class Config {
  static String baseUrl = "";

  static Future<void> loadConfig() async {
    final configString =
        await rootBundle.loadString('assets/config/config.json');
    final configData = jsonDecode(configString);
    baseUrl = configData['baseUrl'];
  }
}

class APIJarakLocal {
  static String get baseUrl => Config.baseUrl;

  static String get listCustomers => "$baseUrl/list_pelanggan";
  static String get getCustomer => "$baseUrl/get_pelanggan";
  static String get listDrivers => "$baseUrl/list_driver";
  static String get getDriver => "$baseUrl/get_driver";
  static String get cekGoogle => "$baseUrl/cek_google";
  static String get submitPengantaran => "$baseUrl/submit_pengantaran";
  static String get historyPengantaran => "$baseUrl/history_pengantaran";
  static String get detailPengantaran => "$baseUrl/detail_pengantaran";
  static String get updateDetailPerjalanan =>
      "$baseUrl/update_detail_perjalanan";
  static String get updateDetailPengantaran =>
      "$baseUrl/update_detail_pengantaran";
  static String get addDeliveryOrder => "$baseUrl/add_delivery_order";
  static String get getDeliveryOrder => "$baseUrl/get_delivery_order";
  static String get detailDeliveryOrder => "$baseUrl/detail_delivery_order";
  static String get listProducts => "$baseUrl/list_produk";
  static String get getProduct => "$baseUrl/get_produk";

  static String get deleteDeliveryOrder =>
      "$baseUrl/delete_detail_delivery_order";
  static String editDeliveryOrder(int id) {
    return "$baseUrl/edit_delivery_order/$id"; // Make sure to return a complete URL string
  }
}
