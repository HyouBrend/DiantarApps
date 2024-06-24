import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:diantar_jarak/bloc/serach_page/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/serach_page/dropdown_customer_bloc/dropdown_customer_event.dart';
import 'package:diantar_jarak/bloc/serach_page/dropdown_customer_bloc/dropdown_customer_state.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/theme/size.dart';
import 'package:diantar_jarak/theme/theme.dart';

class DropdownCustomer extends StatefulWidget {
  final Function(Map<String, String>) onDetailsEntered;

  const DropdownCustomer({super.key, required this.onDetailsEntered});

  @override
  _DropdownCustomerState createState() => _DropdownCustomerState();
}

class _DropdownCustomerState extends State<DropdownCustomer> {
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Sizes.dp94(context),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TypeAheadFormField<DropdownCustomerModel>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: InputDecoration(
                      labelText: 'Customer',
                      hintText: 'Enter customer name',
                      hintStyle:
                          TextStyle(color: CustomColorPalette.hintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      fillColor: CustomColorPalette.surfaceColor,
                    ),
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
                      title: Text(suggestion.displayName ?? ''),
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
                    });
                  },
                  noItemsFoundBuilder: (context) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No customers found',
                        style: TextStyle(color: CustomColorPalette.textColor)),
                  ),
                ),
              ),
              SizedBox(width: Sizes.dp10(context)),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _latitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Latitude',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: Sizes.dp10(context)),
                    TextFormField(
                      controller: _longitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Longitude',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
