import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_event.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_state.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:diantar_jarak/theme/theme.dart';

class SearchHistory extends StatefulWidget {
  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  String? _selectedDriver;
  DropdownDriveModel? selectedDriverModel;
  bool _isLoading = false; // State variable to manage loading state

  void _onSearch() {
    // Perform search operation
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: CustomColorPalette.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'History',
              labelStyle: TextStyle(fontSize: 14),
              hintText: 'Enter history',
              hintStyle: TextStyle(
                  color: CustomColorPalette.hintTextColor, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              filled: true,
              fillColor: CustomColorPalette.surfaceColor,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              isDense: true, // Reduce TextField height
            ),
            style: TextStyle(fontSize: 14),
            onChanged: (value) {
              context
                  .read<DropdownFilterBloc>()
                  .add(FetchDropdownFilterData(query: value));
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Filter Driver',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          BlocListener<DropdownFilterBloc, DropdownFilterState>(
            listener: (context, state) {
              if (state is DropdownFilterLoading) {
                setState(() {
                  _isLoading = true;
                });
              } else {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            child: Container(
              width: Sizes.dp40(context),
              child: TypeAheadField<DropdownDriveModel>(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    labelText: 'Driver',
                    labelStyle: TextStyle(fontSize: 14),
                    hintText: 'Masukkan nama driver',
                    hintStyle: TextStyle(
                        color: CustomColorPalette.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: CustomColorPalette.surfaceColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    isDense: true, // Mengurangi tinggi TextField
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                suggestionsCallback: (pattern) async {
                  context
                      .read<DropdownFilterBloc>()
                      .add(FetchDropdownFilterData(query: pattern));
                  final state = await context
                      .read<DropdownFilterBloc>()
                      .stream
                      .firstWhere(
                        (state) => state is! DropdownFilterLoading,
                      );
                  if (state is DropdownFilterHasData) {
                    return state.drivers.where((driver) => driver.nama!
                        .toLowerCase()
                        .contains(pattern.toLowerCase()));
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
                    _selectedDriver = suggestion.nama;
                    selectedDriverModel = suggestion;
                  });
                  _onSearch();
                },
                noItemsFoundBuilder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Driver tidak ditemukan'),
                ),
                loadingBuilder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                hideOnLoading:
                    !_isLoading, // Mengontrol visibilitas indikator loading
              ),
            ),
          ),
        ],
      ),
    );
  }
}
