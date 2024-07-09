import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class CustomerService {
  final ApiHelper apiHelper;

  CustomerService({required this.apiHelper});

  Future<CustomerData> getAllCustomers() async {
    try {
      final response = await apiHelper.get(
        url: APIJarakLocal.listCustomers,
      );
      final result = response.data as Map<String, dynamic>;
      return CustomerData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerData> getCustomers(String query) async {
    try {
      final response = await apiHelper.get(
        url: query.isEmpty
            ? APIJarakLocal.listCustomers
            : '${APIJarakLocal.getCustomer}/$query',
      );
      final result = response.data as Map<String, dynamic>;
      return CustomerData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}