import 'package:diantar_jarak/bloc/serach_page/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/bloc/serach_page/dropdown_driver_bloc/dropdown_driver_event.dart';
import 'package:diantar_jarak/bloc/serach_page/dropdown_driver_bloc/dropdown_driver_state.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/size.dart';
import 'package:diantar_jarak/theme/theme.dart';
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
          width: Sizes.dp94(context),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TypeAheadFormField<DropdownDriveModel>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      labelText: 'Driver',
                      hintText: 'Enter driver name',
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
                  noItemsFoundBuilder: (context) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No drivers found',
                        style: TextStyle(color: CustomColorPalette.textColor)),
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
