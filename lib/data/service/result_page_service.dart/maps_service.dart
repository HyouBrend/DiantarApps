import 'package:dio/dio.dart';
import 'package:diantar_jarak/data/models/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/models/dropdown_drive_model.dart';

class MapsService {
  final Dio dio = Dio();

  Future<List<DropdownDriveModel>> fetchDrivers() async {
    final response = await dio.get('http://127.0.0.1:8010/proxy/list_driver');
    return (response.data['data'] as List).map((driver) => DropdownDriveModel.fromJson(driver)).toList();
  }

  Future<List<DropdownCustomerModel>> fetchCustomers() async {
    final response = await dio.get('http://127.0.0.1:8010/proxy/list_pelanggan');
    return (response.data['data'] as List).map((customer) => DropdownCustomerModel.fromJson(customer)).toList();
  }
}
