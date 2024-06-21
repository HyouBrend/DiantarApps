import 'package:diantar_jarak/bloc/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/bloc/dropdown_driver_bloc/dropdown_driver_event.dart';
import 'package:diantar_jarak/bloc/dropdown_driver_bloc/dropdown_driver_state.dart';
import 'package:diantar_jarak/data/models/dropdown_drive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DropdownDriver extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onPositionSelected;

  const DropdownDriver({
    super.key,
    required this.controller,
    required this.onPositionSelected,
  });

  @override
  _DropdownDriverState createState() => _DropdownDriverState();
}

class _DropdownDriverState extends State<DropdownDriver> {
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
                child: TypeAheadFormField<DropdownDriveModel>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: widget.controller,
                    decoration: const InputDecoration(
                      labelText: 'Driver',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    context.read<DriverBloc>().add(FetchDrivers(pattern));
                    await Future.delayed(const Duration(milliseconds: 500));
                    final state = context.read<DriverBloc>().state;
                    if (state is DriverLoaded) {
                      return state.drivers.take(10).toList();
                    }
                    return [];
                  },
                  itemBuilder: (context, DropdownDriveModel suggestion) {
                    return ListTile(
                      title: Text(suggestion.nama ?? ''),
                    );
                  },
                  onSuggestionSelected: (DropdownDriveModel suggestion) {
                    setState(() {
                      widget.controller.text = suggestion.nama ?? '';
                      widget.onPositionSelected(suggestion.posisi ?? '');
                    });
                  },
                  noItemsFoundBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No drivers found'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
