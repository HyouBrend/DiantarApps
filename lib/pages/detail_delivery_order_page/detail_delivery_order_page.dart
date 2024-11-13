import 'package:diantar_jarak/data/service/delivery_order_service/delete_detail_delivery_order.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../data/service/delivery_order_service/detail_delivery_order_page.dart';
import 'widget_detail_delivery_order_page/edit_detail_delivery_order_page.dart';

class DetailDeliveryOrderPage extends StatefulWidget {
  final int deliveryOrderId;
  final void Function()? onSuccess;

  const DetailDeliveryOrderPage({
    Key? key,
    required this.deliveryOrderId,
    required this.onSuccess,
  }) : super(key: key);

  @override
  _DetailDeliveryOrderPageState createState() =>
      _DetailDeliveryOrderPageState();
}

class _DetailDeliveryOrderPageState extends State<DetailDeliveryOrderPage> {
  late DetailDeliveryOrderService _detailService;
  late DeleteDeliveryOrderService _deleteService;
  late Future<DeliveryOrder> _deliveryOrder;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _detailService =
        DetailDeliveryOrderService(apiHelper: ApiHelperImpl(dio: Dio()));
    _deleteService =
        DeleteDeliveryOrderService(apiHelper: ApiHelperImpl(dio: Dio()));
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    _deliveryOrder =
        _detailService.getDeliveryOrderById(widget.deliveryOrderId);

    try {
      await _deliveryOrder;
    } catch (e) {
      _showError('Failed to load delivery order: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this delivery order?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await _deleteOrder();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColorPalette.BelumDikirimStats,
                minimumSize: Size(100, 40),
              ),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteOrder() async {
    try {
      final success =
          await _deleteService.deleteDeliveryOrderById(widget.deliveryOrderId);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Delivery order deleted successfully")),
        );
        Navigator.of(context).pop(true); // Close the page and indicate success
        widget.onSuccess?.call(); // Trigger onSuccess callback if defined
      }
    } catch (e) {
      if (mounted) {
        _showError("Failed to delete the delivery order: $e");
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<void> openEditDialog(BuildContext context, DeliveryOrder order) async {
    final result = await showDialog(
      context: context,
      builder: (dialogContext) {
        return EditDeliveryOrderDialog(
          order: order,
          onSuccess: () {
            Navigator.of(dialogContext).pop(true);
            _loadData();
            widget.onSuccess?.call();
          },
        );
      },
    );

    if (result == true) {
      _loadData();
    }
  }

  Widget buildRow(String label, dynamic value, BuildContext context) {
    double getLabelWidth(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth > 1024
          ? 200
          : screenWidth > 768
              ? 150
              : 120;
    }

    double getFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth > 1024
          ? 18
          : screenWidth > 768
              ? 16
              : 14;
    }

    String formattedValue;
    if (value is DateTime) {
      formattedValue = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(value);
    } else {
      formattedValue = value?.toString() ?? 'Unknown';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: getLabelWidth(context),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(context),
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          Text(
            ":",
            style: TextStyle(
                fontSize: getFontSize(context),
                color: CustomColorPalette.textColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              formattedValue,
              style: TextStyle(
                  fontSize: getFontSize(context),
                  color: CustomColorPalette.textColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColorPalette.backgroundColor,
        title: Text(
          'Delivery Order Details',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColorPalette.textColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
          color: CustomColorPalette.backgroundColor,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : FutureBuilder<DeliveryOrder>(
                  future: _deliveryOrder,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text('No data found.'));
                    }

                    DeliveryOrder order = snapshot.data!;
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: CustomColorPalette.BgBorder,
                                  border: Border.all(
                                      color: CustomColorPalette.textColor),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                margin: const EdgeInsets.only(
                                    left: 30, right: 30, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Detail Delivery Order',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: CustomColorPalette.textColor),
                                    ),
                                    const SizedBox(height: 16),
                                    buildRow('Product Name', order.productName,
                                        context),
                                    buildRow('Product Code', order.productCode,
                                        context),
                                    buildRow(
                                        'Opening Balance',
                                        order.openingBalance?.toString() ?? '0',
                                        context),
                                    buildRow(
                                        'Delivery Order',
                                        order.deliveryOrder.toString(),
                                        context),
                                    buildRow(
                                        'Total Seharusnya',
                                        order.totalSeharusnya?.toString() ??
                                            '0',
                                        context),
                                    buildRow('Delivery Date',
                                        order.deliveryDate, context),
                                    buildRow(
                                        'Updated By',
                                        order.updatedBy ?? 'Belum ada update',
                                        context),
                                    buildRow(
                                        'Updated At',
                                        order.updatedAt ?? 'Belum ada update',
                                        context),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 32.0, right: 64.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  onPressed: () =>
                                      openEditDialog(context, order),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        CustomColorPalette.TidakDikirimStats,
                                    minimumSize: Size(100, 40),
                                  ),
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: CustomColorPalette.textColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      _showDeleteConfirmationDialog(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        CustomColorPalette.BelumDikirimStats,
                                    minimumSize: Size(100, 40),
                                  ),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: CustomColorPalette.textColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
