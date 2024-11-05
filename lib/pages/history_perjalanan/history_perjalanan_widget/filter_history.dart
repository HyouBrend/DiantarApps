import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_state.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:intl/intl.dart';

class FilterWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilterChanged;

  const FilterWidget({
    Key? key,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String? selectedDriver;
  String? selectedChecker;
  String? selectedStatus;
  String? selectedTimeline;
  DateTime? startDate;
  DateTime? endDate;
  double? totalJarakKeseluruhan;

  List<DropdownDriveModel> driverList = [];

  void _clearDate(String label) {
    setState(() {
      if (label == 'Start Date') {
        startDate = null;
      } else {
        endDate = null;
      }
    });
    _applyFilters();
  }

  final List<String> statusList = [
    'Sudah Dikirim',
    'Belum Dikirim',
    'Selesai',
    'Tidak Dikirim',
    'Salah Input',
  ];

  final List<String> checkerList = [
    'Dita',
    'Dona',
    'Gita',
    'Linda',
    'Richard',
    'Ryan'
  ];

  final Map<String, String> timelineMapping = {
    'Hari Ini': 'Today',
    'Kemarin': 'Yesterday',
    'Minggu Ini': 'Week',
    'Minggu Lalu': 'LastWeek',
    'Bulan Ini': 'Month',
    'Bulan Lalu': 'LastMonth',
  };

  @override
  void initState() {
    super.initState();
    context.read<DriverBloc>().add(const FetchDrivers());
  }

  void _applyFilters() {
    widget.onFilterChanged({
      'nama_driver': selectedDriver ?? '',
      'created_by': selectedChecker ?? '',
      'status': selectedStatus ?? '',
      'timeline': selectedTimeline != null
          ? timelineMapping[selectedTimeline] ?? ''
          : '', // Convert display value to backend value
      'start_date':
          startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : '',
      'end_date':
          endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : '',
    });
  }

  InputDecoration _inputDecoration(String labelText, {bool hasValue = false}) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      filled: true,
      fillColor: CustomColorPalette.surfaceColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      isDense: true,
      suffixIcon: hasValue
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _clearFilter(labelText);
              },
            )
          : null,
    );
  }

  void _clearFilter(String label) {
    setState(() {
      switch (label) {
        case 'Nama Driver':
          selectedDriver = null;
          break;
        case 'Checker':
          selectedChecker = null;
          break;
        case 'Status':
          selectedStatus = null;
          break;
        case 'Periode': // Changed from 'Timeline' to match the label
          selectedTimeline = null;
          break;
        case 'Start Date':
          startDate = null;
          break;
        case 'End Date':
          endDate = null;
          break;
      }
    });
    _applyFilters();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('id', 'ID'), // Bahasa Indonesia untuk bulan
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          endDate = pickedDate;
        }
      });
      _applyFilters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryPengantaranBloc, HistoryPengantaranState>(
      builder: (context, state) {
        if (state is HistoryLoaded) {
          totalJarakKeseluruhan = state.totalJarak ?? 0.0;
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Filter",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildDriverDropdown(),
                  const SizedBox(width: 8),
                  _buildCheckerDropdown(),
                  const SizedBox(width: 8),
                  _buildStatusDropdown(),
                  const SizedBox(width: 8),
                  _buildTimelineDropdown(),
                  const SizedBox(width: 8),
                  _buildDateField('Start Date', true),
                  const SizedBox(width: 8),
                  _buildDateField('End Date', false),
                  const SizedBox(width: 8),
                  if (selectedDriver != null && selectedDriver!.isNotEmpty)
                    _buildTotalKeseluruhanJarak(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDriverDropdown() {
    return BlocBuilder<DriverBloc, DriverState>(
      builder: (context, state) {
        if (state is DriverHasData) {
          driverList = state.drivers;
        }
        return SizedBox(
          width: 180,
          child: DropdownButtonFormField<String>(
            decoration: _inputDecoration('Nama Driver',
                hasValue: selectedDriver != null),
            items: driverList
                .map((driver) => DropdownMenuItem(
                      value: driver.nama,
                      child: Text(driver.nama ?? ''),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedDriver = value;
              });
              _applyFilters();
            },
            value: selectedDriver,
          ),
        );
      },
    );
  }

  Widget _buildCheckerDropdown() {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<String>(
        decoration:
            _inputDecoration('Checker', hasValue: selectedChecker != null),
        items: checkerList
            .map((checker) => DropdownMenuItem(
                  value: checker,
                  child: Text(checker),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedChecker = value;
          });
          _applyFilters();
        },
        value: selectedChecker,
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<String>(
        decoration:
            _inputDecoration('Status', hasValue: selectedStatus != null),
        items: statusList
            .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedStatus = value;
          });
          _applyFilters();
        },
        value: selectedStatus,
      ),
    );
  }

  Widget _buildTimelineDropdown() {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<String>(
        decoration:
            _inputDecoration('Periode', hasValue: selectedTimeline != null),
        items: timelineMapping.keys
            .map((timeline) => DropdownMenuItem(
                  value: timeline,
                  child: Text(timeline),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedTimeline = value;
          });
          _applyFilters();
        },
        value: selectedTimeline,
      ),
    );
  }

  Widget _buildDateField(String label, bool isStartDate) {
    final selectedDate = isStartDate ? startDate : endDate;

    // Controller untuk menampilkan tanggal dalam format 'dd MMMM yyyy'
    final controller = TextEditingController(
      text: selectedDate != null
          ? DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDate)
          : '',
    );

    return SizedBox(
      width: 180, // Lebar yang cukup untuk menampilkan nama bulan
      child: TextFormField(
        controller: controller,
        decoration: _inputDecoration(label, hasValue: selectedDate != null),
        readOnly: true, // Agar tidak bisa diedit manual, hanya lewat DatePicker
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
            locale:
                const Locale('id', 'ID'), // Bahasa Indonesia untuk nama bulan
          );

          if (pickedDate != null) {
            setState(() {
              if (isStartDate) {
                startDate = pickedDate;
              } else {
                endDate = pickedDate;
              }
            });

            // Terapkan filter dengan format backend 'yyyy-MM-dd'
            _applyFilters();
          }
        },
      ),
    );
  }

  Widget _buildTotalKeseluruhanJarak() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CustomColorPalette.pastelBlue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Total Jarak: ${totalJarakKeseluruhan?.toStringAsFixed(2) ?? '0.0'} km',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
