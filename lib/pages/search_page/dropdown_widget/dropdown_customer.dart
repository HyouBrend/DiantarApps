import 'package:diantar_jarak/bloc/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/dropdown_customer_bloc/dropdown_customer_event.dart';
import 'package:diantar_jarak/bloc/dropdown_customer_bloc/dropdown_customer_state.dart';
import 'package:diantar_jarak/data/models/dropdown_customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


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
          width: 600,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TypeAheadFormField<DropdownCustomerModel>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: const InputDecoration(
                      labelText: 'Customer',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
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
                        'type': suggestion.type ?? '',
                        'location': suggestion.lokasi ?? '',
                        'latitude': suggestion.latitude ?? '',
                        'longitude': suggestion.longitude ?? '',
                      });
                    });
                  },
                  noItemsFoundBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No customers found'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
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
                    const SizedBox(height: 10),
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
