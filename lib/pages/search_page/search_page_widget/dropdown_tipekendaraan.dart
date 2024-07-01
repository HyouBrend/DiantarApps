import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DropdownTipeKendaraan extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onTipeSelected;
  final DropdownDriveModel? selectedDriver;

  const DropdownTipeKendaraan({
    Key? key,
    required this.controller,
    required this.onTipeSelected,
    this.selectedDriver,
  }) : super(key: key);

  @override
  _DropdownTipeKendaraanState createState() => _DropdownTipeKendaraanState();
}

class _DropdownTipeKendaraanState extends State<DropdownTipeKendaraan> {
  TextEditingController _platNomorController = TextEditingController();
  bool _isVehicleTypeSelected = false;

  final Map<String, List<String>> _platNomorByTipeKendaraan = {
    'Pick Up': [
      'B9809BAY',
      'B9028JAC',
      'B9029CAK',
      'B9405BAT',
      'B9785BAX',
      'B9869BAU'
    ],
    'Roda 3': ['B6372JYA', 'B4997KYE'],
    'Truck': ['B9434BCQ']
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TypeAheadFormField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    labelText: 'Tipe Kendaraan',
                    labelStyle: TextStyle(fontSize: 14),
                    hintText: 'Masukkan tipe kendaraan',
                    hintStyle: TextStyle(
                        color: CustomColorPalette.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: CustomColorPalette.surfaceColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    isDense: true, // Reduces the height of the TextField
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                suggestionsCallback: (pattern) async {
                  await Future.delayed(const Duration(milliseconds: 500));
                  return ['Pick Up', 'Roda 3', 'Truck']
                      .where((tipe) =>
                          tipe.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion, style: TextStyle(fontSize: 14)),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    widget.controller.text = suggestion;
                    widget.onTipeSelected(suggestion);
                    _isVehicleTypeSelected = true;
                    _platNomorController
                        .clear(); // Clear plat nomor when vehicle type changes
                  });
                },
                noItemsFoundBuilder: (context) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tidak ada tipe kendaraan ditemukan',
                      style: TextStyle(
                          color: CustomColorPalette.textColor, fontSize: 14)),
                ),
              ),
            ),
            SizedBox(width: 12),
            if (_isVehicleTypeSelected)
              Expanded(
                child: TypeAheadFormField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _platNomorController,
                    decoration: InputDecoration(
                      labelText: 'Nomor Plat',
                      labelStyle: TextStyle(fontSize: 14),
                      hintText: 'Masukkan nomor plat',
                      hintStyle: TextStyle(
                          color: CustomColorPalette.hintTextColor,
                          fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      fillColor: CustomColorPalette.surfaceColor,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      isDense: true, // Reduces the height of the TextField
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                  suggestionsCallback: (pattern) async {
                    final tipe = widget.controller.text;
                    final platNomor = _platNomorByTipeKendaraan[tipe] ?? [];
                    await Future.delayed(const Duration(milliseconds: 500));
                    return platNomor
                        .where((plat) =>
                            plat.toLowerCase().contains(pattern.toLowerCase()))
                        .toList();
                  },
                  itemBuilder: (context, String suggestion) {
                    return ListTile(
                      title: Text(suggestion, style: TextStyle(fontSize: 14)),
                    );
                  },
                  onSuggestionSelected: (String suggestion) {
                    setState(() {
                      _platNomorController.text = suggestion;
                    });
                  },
                  noItemsFoundBuilder: (context) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Tidak ada nomor plat ditemukan',
                        style: TextStyle(
                            color: CustomColorPalette.textColor, fontSize: 14)),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12),
        if (widget.selectedDriver != null)
          Container(
            decoration: BoxDecoration(
              color: CustomColorPalette.BgBorder,
              border: Border.all(color: CustomColorPalette.textColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/${widget.selectedDriver!.nama}.jpeg',
                  height: 600,
                ),
                SizedBox(height: 8),
                Text('Nama: ${widget.selectedDriver!.nama ?? ''}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('No. Telepon: ${widget.selectedDriver!.noHP ?? ''}'),
              ],
            ),
          ),
      ],
    );
  }
}
