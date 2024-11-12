import 'dart:convert';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/edit_detail_delivery_order_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';

class EditDeliveryOrderService {
  final ApiHelper apiHelper;

  EditDeliveryOrderService({required this.apiHelper});

  Future<String> editDeliveryOrder(
      int id, EditDeliveryOrderRequest request) async {
    final response = await apiHelper.post(
      url: APIJarakLocal.editDeliveryOrder(id),
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception('Failed to update the delivery order');
    }
  }
}
