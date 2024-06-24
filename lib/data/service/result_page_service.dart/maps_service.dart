import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';

class MapsService {
  final ApiHelper apiHelper;

  MapsService({required this.apiHelper});

  Future<DropdownDriveModelData> getAllDrivers() async {
    try {
      final result = await apiHelper.get(
        url: APIJarakLocal.listDrivers,
      );
      return DropdownDriveModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

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
}
