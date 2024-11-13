import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';

class DeleteDeliveryOrderService {
  final ApiHelper apiHelper;

  DeleteDeliveryOrderService({required this.apiHelper});

  Future<bool> deleteDeliveryOrderById(int id) async {
    final response =
        await apiHelper.delete(url: '${APIJarakLocal.deleteDeliveryOrder}/$id');
    if (response.statusCode == 200) {
      return true; // Successfully deleted
    } else if (response.statusCode == 404) {
      throw Exception('Delivery order not found');
    } else {
      throw Exception('Failed to delete delivery order');
    }
  }
}
