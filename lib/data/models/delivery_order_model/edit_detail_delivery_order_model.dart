// EditDeliveryOrderRequest model class
import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';

class EditDeliveryOrderRequest {
  final String productName;
  final int deliveryOrder;
  final DateTime deliveryDate;
  final String updatedBy;

  EditDeliveryOrderRequest({
    required this.productName,
    required this.deliveryOrder,
    required this.deliveryDate,
    required this.updatedBy,
  });

  // Convert DeliveryOrder to EditDeliveryOrderRequest
  factory EditDeliveryOrderRequest.fromDeliveryOrder(DeliveryOrder order) {
    return EditDeliveryOrderRequest(
      productName: order.productName ?? '',
      deliveryOrder: order.deliveryOrder ?? 0,
      deliveryDate: order.deliveryDate ?? DateTime.now(),
      updatedBy: order.updatedBy ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'deliveryOrder': deliveryOrder,
      'deliveryDate': deliveryDate.toIso8601String(),
      'updatedBy': updatedBy,
    };
  }
}
