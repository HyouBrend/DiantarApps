import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class DeliveryOrderService {
  final ApiHelper apiHelper;

  DeliveryOrderService({required this.apiHelper});

  Future<PaginatedDeliveryOrderResponse> getDeliveryOrders({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await apiHelper.get(
        url: APIJarakLocal.getDeliveryOrder,
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
      );

      return PaginatedDeliveryOrderResponse.fromJson(response.data);
    } catch (e, stackTrace) {
      print("Error in getDeliveryOrders: $e");
      print("Stack Trace: $stackTrace"); // Capture the error and stack trace
      rethrow; // Continue throwing the error to be caught by the Bloc
    }
  }
}
