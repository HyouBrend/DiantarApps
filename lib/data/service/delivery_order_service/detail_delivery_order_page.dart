import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class DetailDeliveryOrderService {
  final ApiHelper apiHelper;

  DetailDeliveryOrderService({required this.apiHelper});

  // Fetch a delivery order by ID
  Future<DeliveryOrder> getDeliveryOrderById(int id) async {
    try {
      final response = await apiHelper.get(
        url: '${APIJarakLocal.detailDeliveryOrder}/$id', // Endpoint with ID
      );

      // Parse and return the delivery order
      return DeliveryOrder.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
