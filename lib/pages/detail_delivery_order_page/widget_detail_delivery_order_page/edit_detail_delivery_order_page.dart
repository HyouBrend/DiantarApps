import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:intl/intl.dart';
import 'package:diantar_jarak/theme/theme.dart';

class EditDeliveryOrderDialog extends StatefulWidget {
  final DeliveryOrder order;
  final Function(DeliveryOrder) onSubmit;

  const EditDeliveryOrderDialog({
    Key? key,
    required this.order,
    required this.onSubmit,
  }) : super(key: key);

  @override
  _EditDeliveryOrderDialogState createState() =>
      _EditDeliveryOrderDialogState();
}

class _EditDeliveryOrderDialogState extends State<EditDeliveryOrderDialog> {
  late TextEditingController _productNameController;
  late TextEditingController _deliveryOrderController;
  late TextEditingController _deliveryDateController;
  String? _updatedBy;

  final List<String> _updatedByOptions = [
    'Dita',
    'Dona',
    'Gita',
    'Linda',
    'Richard',
    'Ryan',
  ];

  @override
  void initState() {
    super.initState();
    _productNameController =
        TextEditingController(text: widget.order.productName);
    _deliveryOrderController =
        TextEditingController(text: widget.order.deliveryOrder.toString());
    _deliveryDateController = TextEditingController(
        text: widget.order.deliveryDate != null
            ? DateFormat('yyyy-MM-dd').format(widget.order.deliveryDate!)
            : '');

    _updatedBy = _updatedByOptions.contains(widget.order.updatedBy)
        ? widget.order.updatedBy
        : _updatedByOptions.first;
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _deliveryOrderController.dispose();
    _deliveryDateController.dispose();
    super.dispose();
  }

  // Method to show date picker and update the delivery date
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
        _deliveryDateController.text = DateFormat('yyyy-MM-dd')
            .format(pickedDate); // Format the date as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Delivery Order"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Name TextField
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                labelStyle: const TextStyle(fontSize: 14),
                hintText: 'Masukkan product name',
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
            ),
            const SizedBox(height: 12),

            // Delivery Order TextField
            TextField(
              controller: _deliveryOrderController,
              keyboardType: TextInputType.number,
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
            ),
            const SizedBox(height: 12),

            // Delivery Date TextField with DatePicker
            TextField(
              controller: _deliveryDateController,
              decoration: InputDecoration(
                labelText: 'Delivery Date',
                labelStyle: const TextStyle(fontSize: 14),
                hintText: 'Select Delivery Date',
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
                  onPressed: () =>
                      _selectDate(context), // Show date picker on click
                ),
              ),
              readOnly: true,
              onTap: () => _selectDate(context), // Open date picker on tap
            ),
            const SizedBox(height: 12),

            // Dropdown for Updated By
            DropdownButtonFormField<String>(
              value: _updatedBy,
              decoration: InputDecoration(
                labelText: 'Updated By',
                labelStyle: const TextStyle(fontSize: 14),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                filled: true,
                fillColor: CustomColorPalette.surfaceColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                isDense: true,
              ),
              items: _updatedByOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _updatedBy = newValue;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedOrder = DeliveryOrder(
              id: widget.order.id,
              productCode: widget.order.productCode,
              productName: _productNameController.text,
              openingBalance: widget.order.openingBalance,
              qtyIn: widget.order.qtyIn,
              qtyOut: widget.order.qtyOut,
              closingBalance: widget.order.closingBalance,
              deliveryOrder: int.parse(_deliveryOrderController.text),
              totalSeharusnya: widget.order.totalSeharusnya,
              deliveryDate: DateFormat('yyyy-MM-dd').parse(
                  _deliveryDateController
                      .text), // Use the selected or entered date
              updatedAt: DateTime.now(), // Automatically updated
              updatedBy: _updatedBy ?? widget.order.updatedBy, // Handle null
              createdAt: widget.order.createdAt,
              createdBy: widget.order.createdBy,
            );
            widget.onSubmit(
                updatedOrder); // Pass the updated order to the parent widget
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Submit"),
        ),
      ],
    );
  }
}
