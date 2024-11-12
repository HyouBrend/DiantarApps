import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_bloc.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_event.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/produk_model.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/add_delivery_order_service.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/produk_service.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/add_delivery_order_model.dart';
import 'package:diantar_jarak/pages/delivery_order/delivery_order_widget/drodpown_widget/produk_dropdown_widget.dart';

class AddDeliveryOrderWidget extends StatefulWidget {
  final DropProductService dropdownProductService;
  final AddDeliveryOrderService deliveryOrderService;

  const AddDeliveryOrderWidget({
    super.key,
    required this.dropdownProductService,
    required this.deliveryOrderService,
  });

  @override
  _AddDeliveryOrderWidgetState createState() => _AddDeliveryOrderWidgetState();
}

class _AddDeliveryOrderWidgetState extends State<AddDeliveryOrderWidget> {
  List<DeliveryOrderItemContainer> _deliveryOrderItems = [];

  @override
  void initState() {
    super.initState();
    _addNewOrderContainer();
  }

  // Adds a new delivery order item container
  void _addNewOrderContainer() {
    setState(() {
      _deliveryOrderItems.add(DeliveryOrderItemContainer(
        index: _deliveryOrderItems.length,
        dropdownProductService: widget.dropdownProductService,
        onRemove: _removeOrderContainer,
      ));
    });
  }

  // Removes a delivery order item container by index
  void _removeOrderContainer(int index) {
    setState(() {
      _deliveryOrderItems.removeAt(index);
      for (var i = 0; i < _deliveryOrderItems.length; i++) {
        _deliveryOrderItems[i].index = i;
      }
    });
  }

  // Submits the delivery orders
  void _submitOrders() async {
    final List<DeliveryOrderItem> orders = _deliveryOrderItems.map((container) {
      // Parse Indonesian date and format for backend
      DateTime? parsedDate =
          _parseIndonesianDate(container.deliveryDateController.text);

      // Pass formatted deliveryDate directly in the constructor
      return DeliveryOrderItem(
        productCode: container.selectedProduct?.productCode ?? '',
        productName: container.selectedProduct?.name ?? '',
        deliveryOrder:
            int.tryParse(container.deliveryOrderController.text) ?? 0,
        deliveryDate: parsedDate ?? DateTime.now(), // Initialize with DateTime
        createdBy: container.createdByController.text,
      );
    }).toList();

    try {
      String responseMessage =
          await widget.deliveryOrderService.addDeliveryOrder(orders);
      print("Response from server: $responseMessage");

      setState(() {
        _deliveryOrderItems.clear();
        _addNewOrderContainer();
      });

      context.read<DeliveryOrderBloc>().add(FetchDeliveryOrders());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Orders submitted successfully")),
      );
    } catch (e) {
      print("Error submitting orders: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit orders")),
      );
    }
  }

  // Helper function to parse Indonesian date format
  DateTime? _parseIndonesianDate(String dateText) {
    try {
      return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').parse(dateText);
    } catch (e) {
      print("Error parsing date: $dateText");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Delivery Order',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CustomColorPalette.textColor,
                  ),
                ),
                SizedBox(height: 16.0),
                Column(
                  children: _deliveryOrderItems,
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.buttonColor,
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    child: IconButton(
                      onPressed: _addNewOrderContainer,
                      icon: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: _submitOrders,
              child: Text('Submit Orders'),
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColorPalette.SudahDikirimStats,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DeliveryOrderItemContainer extends StatefulWidget {
  final DropProductService dropdownProductService;
  final Function(int) onRemove;
  int index;

  DeliveryOrderItemContainer({
    required this.dropdownProductService,
    required this.onRemove,
    required this.index,
    Key? key,
  }) : super(key: key);

  final TextEditingController productController = TextEditingController();
  final TextEditingController deliveryOrderController = TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();
  final TextEditingController createdByController = TextEditingController();
  DropdownProductModel? selectedProduct;

  DeliveryOrderItem getDeliveryOrderItem({required String createdBy}) {
    return DeliveryOrderItem(
      productCode: selectedProduct?.productCode ?? '',
      productName: selectedProduct?.name ?? '',
      deliveryOrder: int.tryParse(deliveryOrderController.text) ?? 0,
      deliveryDate: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
          .parse(deliveryDateController.text),
      createdBy: createdBy,
    );
  }

  @override
  _DeliveryOrderItemContainerState createState() =>
      _DeliveryOrderItemContainerState();
}

class _DeliveryOrderItemContainerState
    extends State<DeliveryOrderItemContainer> {
  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'), // Set to Indonesian locale
    );

    if (pickedDate != null) {
      setState(() {
        widget.deliveryDateController.text =
            DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CustomColorPalette.lavender,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: CustomColorPalette.textColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownProduct(
            controller: widget.productController,
            onCategorySelected: (String category) {
              print('Selected Category: $category');
            },
            onProductSelected: (DropdownProductModel product) {
              setState(() {
                widget.selectedProduct = product;
                widget.productController.text = product.name ?? '';
              });
            },
          ),
          const SizedBox(height: 8.0),
          DropdownAgent(
            controller: widget.createdByController,
            onAgentSelected: (String agent) {
              setState(() {
                widget.createdByController.text = agent;
                print("Selected Agent: $agent");
              });
            },
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: widget.deliveryOrderController,
            decoration: InputDecoration(
              labelText: 'Delivery Order',
              labelStyle: const TextStyle(fontSize: 14),
              hintText: 'Masukkan delivery order',
              hintStyle: TextStyle(
                color: CustomColorPalette.hintTextColor,
                fontSize: 14,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              filled: true,
              fillColor: CustomColorPalette.surfaceColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: widget.deliveryDateController,
            decoration: InputDecoration(
              labelText: 'Delivery Date',
              labelStyle: const TextStyle(fontSize: 14),
              hintText: 'Pilih tanggal pengiriman',
              hintStyle: TextStyle(
                color: CustomColorPalette.hintTextColor,
                fontSize: 14,
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              filled: true,
              fillColor: CustomColorPalette.surfaceColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              isDense: true,
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today,
                    color: CustomColorPalette.textColor),
                onPressed: () => _selectDate(context),
              ),
            ),
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => widget.onRemove(widget.index),
              child: Text('Remove', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColorPalette.buttonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
