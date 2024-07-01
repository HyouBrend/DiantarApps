import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/models/model_page_result/result_maps_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class CustomerService {
  final ApiHelper apiHelper;

  CustomerService({required this.apiHelper});

  Future<CustomerData> getAllCustomers() async {
    try {
      final result = await apiHelper.get(
        url: APIJarakLocal.listCustomers,
      );
      return CustomerData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerData> getCustomers(String query) async {
    try {
      final result = await apiHelper.get(
        url: query.isEmpty
            ? APIJarakLocal.listCustomers
            : '${APIJarakLocal.getCustomer}/$query',
      );
      return CustomerData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MapsResultsModel>> getMapsResults() async {
    try {
      final result = await apiHelper.get(url: APIJarakLocal.listCustomers);
      final customerData = CustomerData.fromJson(result);

      final mapsResults = customerData.data
              ?.map((customer) =>
                  MapsResultsModel.fromDropdownCustomerModel(customer))
              .toList() ??
          [];

      return mapsResults;
    } catch (e) {
      rethrow;
    }
  }
}
