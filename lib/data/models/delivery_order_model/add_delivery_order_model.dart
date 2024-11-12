class DeliveryOrderItem {
  final String productCode;
  final String productName;
  final int deliveryOrder;
  final DateTime deliveryDate;
  final String createdBy;

  DeliveryOrderItem({
    required this.productCode,
    required this.productName,
    required this.deliveryOrder,
    required this.deliveryDate,
    required this.createdBy,
  });

  factory DeliveryOrderItem.fromJson(Map<String, dynamic> json) {
    return DeliveryOrderItem(
      productCode: json['product_code'],
      productName: json['product_name'],
      deliveryOrder: json['delivery_order'],
      deliveryDate: DateTime.parse(json['delivery_date']),
      createdBy: json['created_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_code': productCode,
      'product_name': productName,
      'delivery_order': deliveryOrder,
      'delivery_date': deliveryDate.toIso8601String(),
      'created_by': createdBy,
    };
  }
}
