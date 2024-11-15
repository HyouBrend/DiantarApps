import 'package:diantar_jarak/data/models/delivery_order_model/edit_detail_delivery_order_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/edit_detail_delivery_order_service.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:dio/dio.dart';

class EditDeliveryOrderDialog extends StatefulWidget {
  final DeliveryOrder order;
  final void Function()? onSuccess;

  const EditDeliveryOrderDialog({
    super.key,
    required this.order,
    this.onSuccess,
  });

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
          : '',
    );

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

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'),
    );

    if (pickedDate != null) {
      setState(() {
        _deliveryDateController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _submitForm() async {
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
      deliveryDate:
          DateFormat('yyyy-MM-dd').parse(_deliveryDateController.text),
      updatedAt: DateTime.now(),
      updatedBy: _updatedBy ?? widget.order.updatedBy,
      createdAt: widget.order.createdAt,
      createdBy: widget.order.createdBy,
    );

    final editRequest =
        EditDeliveryOrderRequest.fromDeliveryOrder(updatedOrder);

    try {
      await EditDeliveryOrderService(
        apiHelper: ApiHelperImpl(dio: Dio()),
      ).editDeliveryOrder(widget.order.id, editRequest);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil diperbarui')),
      );

      widget.onSuccess?.call();
      Navigator.of(context).pop();
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui data: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Pengiriman Barang"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Nama Produk',
                hintText: 'Masukkan nama produk',
                hintStyle: TextStyle(color: CustomColorPalette.hintTextColor),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: CustomColorPalette.surfaceColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _deliveryOrderController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nomor Pengiriman',
                hintText: 'Masukkan nomor pengiriman',
                hintStyle: TextStyle(color: CustomColorPalette.hintTextColor),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: CustomColorPalette.surfaceColor,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _deliveryDateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Pengiriman',
                hintText: 'Pilih tanggal pengiriman',
                hintStyle: TextStyle(color: CustomColorPalette.hintTextColor),
                border: const OutlineInputBorder(),
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
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _updatedBy,
              decoration: InputDecoration(
                labelText: 'Diperbarui Oleh',
                border: const OutlineInputBorder(),
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text("Kirim"),
        ),
      ],
    );
  }
}
