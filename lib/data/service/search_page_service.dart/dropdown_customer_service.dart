import 'package:diantar_jarak/data/models/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/network/api_helper.dart';

class CustomerService {
  final ApiHelper apiHelper;

  CustomerService({required this.apiHelper});

  Future<CustomerData> getAllCustomers() async {
    try {
      final result = await apiHelper.get(
        url: 'http://127.0.0.1:8010/proxy/list_pelanggan',
      );
      return CustomerData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerData> getCustomers(String query) async {
    try {
      final result = await apiHelper.get(
        url: query.isEmpty ? 'http://127.0.0.1:8010/proxy/list_pelanggan' : 'http://127.0.0.1:8010/proxy/get_pelanggan/$query',
      );
      return CustomerData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}
