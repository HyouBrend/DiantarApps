import 'package:diantar_jarak/data/models/delivery_order_model/add_delivery_order_model.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class AddDeliveryOrderService {
  final ApiHelper apiHelper;

  AddDeliveryOrderService({required this.apiHelper});

  // Function to submit a list of delivery orders
  Future<String> addDeliveryOrder(
      List<DeliveryOrderItem> deliveryOrders) async {
    // Convert the list of DeliveryOrderItem objects to JSON
    final requestBody = deliveryOrders.map((order) => order.toJson()).toList();

    // Make a POST request
    final response = await apiHelper.post(
      url: APIJarakLocal.addDeliveryOrder,
      body: requestBody,
    );

    // Return the success message from the response
    return response.data['message'];
  }

  // Function to fetch the list of delivery orders
  Future<List<DeliveryOrder>> getDeliveryOrders() async {
    final response = await apiHelper.get(url: APIJarakLocal.getDeliveryOrder);

    // Convert the JSON response to a list of DeliveryOrder objects
    return (response.data['data'] as List)
        .map((json) => DeliveryOrder.fromJson(json))
        .toList();
  }
}
