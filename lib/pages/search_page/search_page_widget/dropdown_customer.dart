import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_customer_bloc/dropdown_customer_event.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_customer_bloc/dropdown_customer_state.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/theme/size.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DropdownCustomer extends StatefulWidget {
  final Function(Map<String, String>) onDetailsEntered;
  final Function(DropdownCustomerModel) onCustomerSelected;
  final DropdownCustomerModel? selectedCustomer;

  const DropdownCustomer({
    super.key,
    required this.onDetailsEntered,
    required this.onCustomerSelected,
    this.selectedCustomer,
  });

  @override
  _DropdownCustomerState createState() => _DropdownCustomerState();
}

class _DropdownCustomerState extends State<DropdownCustomer> {
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  void _launchMapsUrl(String lat, String lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TypeAheadFormField<DropdownCustomerModel>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _typeAheadController,
                  decoration: InputDecoration(
                    labelText: 'Pelanggan',
                    labelStyle: TextStyle(fontSize: 14),
                    hintText: 'Masukkan Nama Pelanggan',
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
                  context.read<CustomerBloc>().add(FetchCustomers(pattern));
                  await Future.delayed(const Duration(milliseconds: 500));
                  final state = context.read<CustomerBloc>().state;
                  if (state is CustomerLoaded) {
                    return state.customers.take(10).toList();
                  }
                  return [];
                },
                itemBuilder: (context, DropdownCustomerModel suggestion) {
                  return ListTile(
                    title: Text(suggestion.displayName ?? '',
                        style: TextStyle(fontSize: 14)),
                  );
                },
                onSuggestionSelected: (DropdownCustomerModel suggestion) {
                  setState(() {
                    _typeAheadController.text = suggestion.displayName ?? '';
                    _latitudeController.text = suggestion.latitude ?? '';
                    _longitudeController.text = suggestion.longitude ?? '';
                    widget.onDetailsEntered({
                      'name': suggestion.displayName ?? '',
                      'latitude': suggestion.latitude ?? '',
                      'longitude': suggestion.longitude ?? '',
                    });
                    widget.onCustomerSelected(suggestion);
                  });
                },
                noItemsFoundBuilder: (context) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Pelanggan Tidak Ada',
                      style: TextStyle(
                          color: CustomColorPalette.textColor, fontSize: 14)),
                ),
              ),
            ),
            SizedBox(width: Sizes.dp4(context)),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(fontSize: 14),
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
            ),
            SizedBox(width: Sizes.dp4(context)),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(fontSize: 14),
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
            ),
            SizedBox(width: Sizes.dp4(context)),
            IconButton(
              icon:
                  Icon(Icons.location_on, color: CustomColorPalette.textColor),
              onPressed: () {
                final lat = _latitudeController.text;
                final lon = _longitudeController.text;
                if (lat.isNotEmpty && lon.isNotEmpty) {
                  _launchMapsUrl(lat, lon);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Latitude dan Longitude tidak boleh kosong'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        SizedBox(height: 12),
        if (widget.selectedCustomer != null) Container(),
      ],
    );
  }
}
