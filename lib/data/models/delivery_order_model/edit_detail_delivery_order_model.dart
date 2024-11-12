import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:intl/intl.dart';

class EditDeliveryOrderRequest {
  final String productName;
  final int deliveryOrder;
  final String updatedBy;
  final DateTime deliveryDate; // Change to DateTime

  EditDeliveryOrderRequest({
    required this.productName,
    required this.deliveryOrder,
    required this.updatedBy,
    required this.deliveryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'deliveryOrder': deliveryOrder,
      'updatedBy': updatedBy,
      'deliveryDate':
          DateFormat('yyyy-MM-dd').format(deliveryDate), // Format as String
    };
  }

  factory EditDeliveryOrderRequest.fromOrder(DeliveryOrder order) {
    return EditDeliveryOrderRequest(
      productName: order.productName ?? '',
      deliveryOrder: order.deliveryOrder ?? 0,
      updatedBy: order.updatedBy ?? '',
      deliveryDate: order.deliveryDate ?? DateTime.now(), // Now DateTime
    );
  }
}
