import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_result/nomor_faktur_model.dart';

class NomorFakturDialog extends StatefulWidget {
  final NomorFakturModel customer;

  const NomorFakturDialog({Key? key, required this.customer}) : super(key: key);

  @override
  _NomorFakturDialogState createState() => _NomorFakturDialogState();
}

class _NomorFakturDialogState extends State<NomorFakturDialog> {
  final TextEditingController _nomorFakturController = TextEditingController();
  final TextEditingController _perjalananIdController = TextEditingController();
  final TextEditingController _shiftKeController = TextEditingController();
  final TextEditingController _jamPengirimanController =
      TextEditingController();
  final TextEditingController _jamKembaliController = TextEditingController();
  final TextEditingController _urutanPengirimanController =
      TextEditingController();
  final TextEditingController _driverIdController = TextEditingController();
  final TextEditingController _namaDriverController = TextEditingController();
  final TextEditingController _kontakIdController = TextEditingController();
  final TextEditingController _inputLatitudeController =
      TextEditingController();
  final TextEditingController _inputLongitudeController =
      TextEditingController();
  final TextEditingController _tipeKendaraanController =
      TextEditingController();
  final TextEditingController _nomorPolisiKendaraanController =
      TextEditingController();
  final TextEditingController _googleMapUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomorFakturController.text = widget.customer.nomorFaktur ?? '';
    _perjalananIdController.text = widget.customer.perjalananId ?? '';
    _shiftKeController.text = widget.customer.shiftKe?.toString() ?? '';
    _jamPengirimanController.text = widget.customer.jamPengiriman ?? '';
    _jamKembaliController.text = widget.customer.jamKembali ?? '';
    _urutanPengirimanController.text =
        widget.customer.urutanPengiriman?.toString() ?? '';
    _driverIdController.text = widget.customer.driverId ?? '';
    _namaDriverController.text = widget.customer.namaDriver ?? '';
    _kontakIdController.text = widget.customer.kontakId ?? '';
    _inputLatitudeController.text = widget.customer.inputLatitude ?? '';
    _inputLongitudeController.text = widget.customer.inputLongitude ?? '';
    _tipeKendaraanController.text = widget.customer.tipeKendaraan ?? '';
    _nomorPolisiKendaraanController.text =
        widget.customer.nomorPolisiKendaraan ?? '';
    _googleMapUrlController.text = widget.customer.googleMapUrl ?? '';
  }

  void _updateCustomer() {
    if (_nomorFakturController.text.isNotEmpty &&
        _perjalananIdController.text.isNotEmpty &&
        _shiftKeController.text.isNotEmpty &&
        _jamPengirimanController.text.isNotEmpty &&
        _jamKembaliController.text.isNotEmpty &&
        _urutanPengirimanController.text.isNotEmpty &&
        _driverIdController.text.isNotEmpty &&
        _namaDriverController.text.isNotEmpty &&
        _kontakIdController.text.isNotEmpty &&
        _inputLatitudeController.text.isNotEmpty &&
        _inputLongitudeController.text.isNotEmpty &&
        _tipeKendaraanController.text.isNotEmpty &&
        _nomorPolisiKendaraanController.text.isNotEmpty &&
        _googleMapUrlController.text.isNotEmpty) {
      setState(() {
        widget.customer.nomorFaktur = _nomorFakturController.text;
        widget.customer.perjalananId = _perjalananIdController.text;
        widget.customer.shiftKe = int.tryParse(_shiftKeController.text);
        widget.customer.jamPengiriman = _jamPengirimanController.text;
        widget.customer.jamKembali = _jamKembaliController.text;
        widget.customer.urutanPengiriman =
            int.tryParse(_urutanPengirimanController.text);
        widget.customer.driverId = _driverIdController.text;
        widget.customer.namaDriver = _namaDriverController.text;
        widget.customer.kontakId = _kontakIdController.text;
        widget.customer.inputLatitude = _inputLatitudeController.text;
        widget.customer.inputLongitude = _inputLongitudeController.text;
        widget.customer.tipeKendaraan = _tipeKendaraanController.text;
        widget.customer.nomorPolisiKendaraan =
            _nomorPolisiKendaraanController.text;
        widget.customer.googleMapUrl = _googleMapUrlController.text;
      });
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Customer'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _nomorFakturController,
              decoration: InputDecoration(labelText: 'Nomor Faktur'),
            ),
            TextField(
              controller: _perjalananIdController,
              decoration: InputDecoration(labelText: 'Perjalanan ID'),
            ),
            TextField(
              controller: _shiftKeController,
              decoration: InputDecoration(labelText: 'Shift Ke'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _jamPengirimanController,
              decoration: InputDecoration(labelText: 'Jam Pengiriman'),
            ),
            TextField(
              controller: _jamKembaliController,
              decoration: InputDecoration(labelText: 'Jam Kembali'),
            ),
            TextField(
              controller: _urutanPengirimanController,
              decoration: InputDecoration(labelText: 'Urutan Pengiriman'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _driverIdController,
              decoration: InputDecoration(labelText: 'Driver ID'),
            ),
            TextField(
              controller: _namaDriverController,
              decoration: InputDecoration(labelText: 'Nama Driver'),
            ),
            TextField(
              controller: _kontakIdController,
              decoration: InputDecoration(labelText: 'Kontak ID'),
            ),
            TextField(
              controller: _inputLatitudeController,
              decoration: InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _inputLongitudeController,
              decoration: InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _tipeKendaraanController,
              decoration: InputDecoration(labelText: 'Tipe Kendaraan'),
            ),
            TextField(
              controller: _nomorPolisiKendaraanController,
              decoration: InputDecoration(labelText: 'Nomor Polisi Kendaraan'),
            ),
            TextField(
              controller: _googleMapUrlController,
              decoration: InputDecoration(labelText: 'Google Map URL'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _updateCustomer,
          child: Text('Update'),
        ),
      ],
    );
  }
}
