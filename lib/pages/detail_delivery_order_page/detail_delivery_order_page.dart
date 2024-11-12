import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/edit_delivery_order_bloc/edit_delivery_order_bloc.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/edit_delivery_order_bloc/edit_delivery_order_event.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/edit_delivery_order_bloc/edit_delivery_order_state.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/edit_detail_delivery_order_model.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/detail_delivery_order_page.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/edit_detail_delivery_order_service.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:dio/dio.dart';
import 'widget_detail_delivery_order_page/edit_detail_delivery_order_page.dart';
import 'package:intl/intl.dart';

class DetailDeliveryOrderPage extends StatefulWidget {
  final int deliveryOrderId;

  const DetailDeliveryOrderPage({super.key, required this.deliveryOrderId});

  @override
  _DetailDeliveryOrderPageState createState() =>
      _DetailDeliveryOrderPageState();
}

class _DetailDeliveryOrderPageState extends State<DetailDeliveryOrderPage> {
  late DetailDeliveryOrderService _service;
  late Future<DeliveryOrder> _deliveryOrder;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service = DetailDeliveryOrderService(apiHelper: ApiHelperImpl(dio: Dio()));
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    _deliveryOrder = _service.getDeliveryOrderById(widget.deliveryOrderId);

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
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle delete action here
                Navigator.of(context).pop();
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

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> openEditDialog(BuildContext context, DeliveryOrder order) async {
    final result = await showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider(
          create: (_) => EditDeliveryOrderBloc(
            editDeliveryOrderService:
                EditDeliveryOrderService(apiHelper: ApiHelperImpl(dio: Dio())),
          ),
          child: EditDeliveryOrderDialog(
            order: order,
            onSubmit: (updatedOrder) async {
              context.read<EditDeliveryOrderBloc>().add(
                    SubmitEditDeliveryOrder(
                      deliveryOrderId: updatedOrder.id,
                      updatedData:
                          EditDeliveryOrderRequest.fromOrder(updatedOrder),
                    ),
                  );
            },
          ),
        );
      },
    );

    if (result == true) {
      _loadData(); // Reload data after successful edit
    }
  }

  Widget buildRow(String label, dynamic value, BuildContext context) {
    double getLabelWidth(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 1024) return 200;
      if (screenWidth > 768 && screenWidth <= 1024) return 150;
      return 120;
    }

    double getFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 1024) return 18;
      if (screenWidth > 768 && screenWidth <= 1024) return 16;
      return 14;
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
          Text(":",
              style: TextStyle(
                  fontSize: getFontSize(context),
                  color: CustomColorPalette.textColor)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(formattedValue,
                style: TextStyle(
                    fontSize: getFontSize(context),
                    color: CustomColorPalette.textColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditDeliveryOrderBloc, EditDeliveryOrderState>(
      listener: (context, state) {
        if (state is EditDeliveryOrderSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.of(context).pop(true); // Close dialog and reload
        } else if (state is EditDeliveryOrderError) {
          _showError(state.message); // Show error if update failed
        }
      },
      child: Scaffold(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Detail Delivery Order',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                CustomColorPalette.textColor),
                                      ),
                                      const SizedBox(height: 16),
                                      buildRow('Product Name',
                                          order.productName, context),
                                      buildRow('Product Code',
                                          order.productCode, context),
                                      buildRow(
                                          'Opening Balance',
                                          order.openingBalance?.toString() ??
                                              '0',
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
      ),
    );
  }
}
