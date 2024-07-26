import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_event.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:diantar_jarak/theme/theme.dart';

class FilterHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Memanggil event untuk fetch data driver saat widget pertama kali di build
    context.read<FilterBloc>().add(const FetchDrivers());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: Sizes.dp2(context)),
          BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.error != null) {
                return Center(child: Text('Error: ${state.error}'));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: Sizes.dp4(context),
                      runSpacing: Sizes.dp4(context),
                      alignment: WrapAlignment.start,
                      children: [
                        SizedBox(
                          width: Sizes.dp30(context),
                          child: DropdownWidget(
                            items: state.drivers,
                            hint: 'Pilih Driver',
                            value: state.driver,
                            onChanged: (value) {
                              context
                                  .read<FilterBloc>()
                                  .add(DriverFilterChanged(value));
                            },
                          ),
                        ),
                        SizedBox(
                          width: Sizes.dp30(context),
                          child: DropdownWidget(
                            items: ['Dita', 'Dona', 'Gita', 'Linda', 'Richard'],
                            hint: 'Pilih Checker',
                            value: state.checker,
                            onChanged: (value) {
                              context
                                  .read<FilterBloc>()
                                  .add(CheckerFilterChanged(value));
                            },
                          ),
                        ),
                        SizedBox(
                          width: Sizes.dp30(context),
                          child: DropdownWidget(
                            items: [
                              'Sudah Dikirim',
                              'Belum Dikirim',
                              'Tidak Dikirim',
                              'Salah Input'
                            ],
                            hint: 'Pilih Status',
                            value: state.status,
                            onChanged: (value) {
                              context
                                  .read<FilterBloc>()
                                  .add(StatusFilterChanged(value));
                            },
                          ),
                        ),
                        SizedBox(
                          width: Sizes.dp30(context),
                          child: DropdownWidget(
                            items: ["Hari ini", "Kemarin", "7 hari terakhir"],
                            hint: 'Pilih Waktu',
                            value: state.time,
                            onChanged: (value) {
                              context
                                  .read<FilterBloc>()
                                  .add(TimeFilterChanged(value));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  final String hint;
  final String? value;
  final Function(String) onChanged;

  DropdownWidget({
    required this.items,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.dp8(context),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColorPalette.surfaceColor,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint),
          value: items.contains(value) ? value : null,
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text(
                hint,
              ),
            ),
            ...items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ],
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          isExpanded: true,
          dropdownColor: CustomColorPalette.surfaceColor,
          icon: Icon(Icons.arrow_drop_down),
          menuMaxHeight: 500, // Set maximum height for dropdown menu
        ),
      ),
    );
  }
}
