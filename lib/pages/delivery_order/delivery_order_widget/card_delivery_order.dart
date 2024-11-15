import 'package:diantar_jarak/pages/detail_delivery_order_page/detail_delivery_order_page.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';

class DeliveryOrderCard extends StatelessWidget {
  final DeliveryOrder order;
  final void Function()? onOrderUpdated; // Changed Function to void Function()?

  const DeliveryOrderCard({
    super.key,
    required this.order,
    required this.onOrderUpdated,
  });

  // Format DateTime to a readable string
  String formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);
  }

  // Function to format quantity values
  String formatQuantity(dynamic quantity) {
    return quantity?.toString() ?? '0';
  }

  // Navigate to the detail page of the delivery order
  Future<void> navigateToDetailPage(BuildContext context) async {
    final bool? updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailDeliveryOrderPage(
          deliveryOrderId: order.id,
          onSuccess: onOrderUpdated,
        ),
      ),
    );

    if (updated == true) {
      onOrderUpdated?.call(); // Call refresh if updated
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          navigateToDetailPage(context), // Navigate to detail page on tap
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: CustomColorPalette.lavender,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Product name and created by
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColorPalette.pastelOrange,
                          border:
                              Border.all(color: CustomColorPalette.textColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          order.productName ?? 'Unknown Product',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColorPalette.pastelGray,
                          border:
                              Border.all(color: CustomColorPalette.textColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          order.createdBy ?? 'Unknown',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Center Column: Opening balance and delivery order quantity
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColorPalette.pastelBlue,
                          border:
                              Border.all(color: CustomColorPalette.textColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Opening Balance: ${formatQuantity(order.openingBalance)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColorPalette.pastelGreen,
                          border:
                              Border.all(color: CustomColorPalette.textColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Delivery Order: ${formatQuantity(order.deliveryOrder)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Right Column: Total Seharusnya and Delivery Date
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColorPalette.pastelYellow,
                          border:
                              Border.all(color: CustomColorPalette.textColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Total Seharusnya: ${formatQuantity(order.totalSeharusnya)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColorPalette.textColor,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColorPalette.pastelPink,
                          border:
                              Border.all(color: CustomColorPalette.textColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Delivery Date: ${formatDate(order.deliveryDate)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
