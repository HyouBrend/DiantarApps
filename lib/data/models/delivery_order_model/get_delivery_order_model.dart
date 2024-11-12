import 'package:intl/intl.dart';

class DeliveryOrder {
  final int id;
  final String? productCode;
  final String? productName;
  final int? openingBalance;
  final int? qtyIn;
  final int? qtyOut;
  final int? closingBalance;
  final int? deliveryOrder;
  final int? totalSeharusnya;
  final DateTime? deliveryDate;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? createdAt;
  final String? createdBy;

  DeliveryOrder({
    required this.id,
    this.productCode,
    this.productName,
    this.openingBalance,
    this.qtyIn,
    this.qtyOut,
    this.closingBalance,
    this.deliveryOrder,
    this.totalSeharusnya,
    this.deliveryDate,
    this.updatedAt,
    this.updatedBy,
    this.createdAt,
    this.createdBy,
  });

  // Custom date parsing function
  static DateTime? DateFormatDeliveryOrder(String? dateStr) {
    if (dateStr == null) return null;
    try {
      // Define the specific format for parsing
      return DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'", 'en_US')
          .parse(dateStr, true)
          .toLocal();
    } catch (e) {
      print('Date parsing error: $e');
      return null;
    }
  }

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) {
    int? parseToInt(dynamic value) {
      if (value is int) {
        return value;
      } else if (value is String) {
        return int.tryParse(value.split('.')[0]);
      }
      return null;
    }

    return DeliveryOrder(
      id: json['id'] as int,
      productCode: json['product_code'] as String?,
      productName: json['product_name'] as String?,
      openingBalance: parseToInt(json['opening_balance']),
      qtyIn: parseToInt(json['qty_in']),
      qtyOut: parseToInt(json['qty_out']),
      closingBalance: parseToInt(json['closing_balance']),
      deliveryOrder: parseToInt(json['delivery_order']),
      totalSeharusnya: parseToInt(json['total_seharusnya']),
      deliveryDate: DateFormatDeliveryOrder(json['delivery_date']),
      updatedAt: DateFormatDeliveryOrder(json['updated_at']),
      createdAt: DateFormatDeliveryOrder(json['created_at']),
      updatedBy: json['updated_by'] as String?,
      createdBy: json['created_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_code': productCode,
      'product_name': productName,
      'opening_balance': openingBalance,
      'qty_in': qtyIn,
      'qty_out': qtyOut,
      'closing_balance': closingBalance,
      'delivery_order': deliveryOrder,
      'total_seharusnya': totalSeharusnya,
      'delivery_date': deliveryDate?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_by': updatedBy,
      'created_by': createdBy,
    };
  }
}

class PaginatedDeliveryOrderResponse {
  final List<DeliveryOrder> data;
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  PaginatedDeliveryOrderResponse({
    required this.data,
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginatedDeliveryOrderResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedDeliveryOrderResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => DeliveryOrder.fromJson(item as Map<String, dynamic>))
          .toList(),
      currentPage: json['pagination']['current_page'] as int,
      pageSize: json['pagination']['page_size'] as int,
      totalItems: json['pagination']['total_items'] as int,
      totalPages: json['pagination']['total_pages'] as int,
    );
  }
}
