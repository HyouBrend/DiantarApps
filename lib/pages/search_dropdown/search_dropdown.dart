import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_state.dart';
import 'package:diantar_jarak/data/models/submit_perjalanan_model/submit_perjalanan_model.dart';
import 'package:diantar_jarak/data/service/submit_perjalanan_service/submit_perjalanan_service.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/show_load.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_footer_widget/search_footer_widget.dart';
import 'package:diantar_jarak/pages/submit_perjalanan/submit_pengantaran.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/cek_google_widget/container_cek_google.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_page.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/cek_google_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_customer.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_agent.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_driver.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_shift.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_tipekendaraan.dart';
import 'package:dio/dio.dart';

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchDropdown> {
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _jamPengirimanController =
      TextEditingController();
  final TextEditingController _jamKembaliController = TextEditingController();
  final TextEditingController _tipeKendaraanController =
      TextEditingController();
  final TextEditingController _nomorPolisiKendaraanController =
      TextEditingController();
  final TextEditingController _agentController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  DropdownDriveModel? _selectedDriver;
  DropdownVehicleModel? _selectedVehicle;
  final List<DropdownCustomerModel> _selectedCustomers = [];
  late final SubmitPerjalananBloc submitPerjalananBloc;

  late final ApiHelper apiHelper;
  late final CekGoogleService cekGoogleService;

  _SearchPageState() {
    apiHelper = ApiHelperImpl(dio: Dio());
    cekGoogleService = CekGoogleService(apiHelper: apiHelper);
    submitPerjalananBloc = SubmitPerjalananBloc(
        submitPerjalananService: SubmitPerjalananService(apiHelper: apiHelper));
  }

  double _getResponsiveMargin(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1024) {
      return 200;
    } else if (width > 768 && width <= 1024) {
      return 100;
    } else {
      return 20;
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
  }

  void _addCustomerDropdown() {
    setState(() {
      _selectedCustomers.add(
        DropdownCustomerModel(
          kontakID: UniqueKey().toString(),
          displayName: '',
          type: '',
          latitude: '',
          lokasi: '',
          longitude: '',
          nomorFaktur: '',
          urutanPengiriman: 0,
        ),
      );
    });
  }

  void _removeCustomerDropdown(DropdownCustomerModel customer) {
    setState(() {
      _selectedCustomers.remove(customer);
    });
  }

  Widget _buildCustomerDropdown(DropdownCustomerModel customer) {
    return Column(
      key: ValueKey(customer.kontakID),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: DropdownCustomer(
                onDetailsEntered: (newDetails) {},
                onCustomerSelected: (selectedCustomer) {
                  setState(() {
                    int index = _selectedCustomers.indexOf(customer);
                    _selectedCustomers[index] = selectedCustomer;
                  });
                },
                selectedCustomer: customer,
              ),
            ),
            const SizedBox(width: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () => _removeCustomerDropdown(customer),
                style: ElevatedButton.styleFrom(
                  foregroundColor: CustomColorPalette.buttonTextColor,
                  backgroundColor: CustomColorPalette.buttonColor,
                ),
                child: const Icon(Icons.remove),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _submitData(BuildContext context) async {
    try {
      // Validasi apakah customers dan driver sudah dipilih
      if (_selectedCustomers.isEmpty || _selectedDriver == null) {
        throw const FormatException("Selected customers or driver is invalid");
      }

      // Pisahkan pelanggan yang memiliki dan tidak memiliki latitude/longitude
      List<DropdownCustomerModel> validCustomers = [];
      List<DropdownCustomerModel> invalidCustomers = [];

      for (var customer in _selectedCustomers) {
        if (customer.latitude.isNotEmpty && customer.longitude.isNotEmpty) {
          validCustomers.add(customer);
        } else {
          invalidCustomers.add(customer); // Simpan pelanggan tanpa lokasi
        }
      }

      // Panggil API cekGoogle hanya untuk pelanggan yang memiliki lokasi valid
      final cekGoogleResult =
          await cekGoogleService.cekGoogle(validCustomers, _selectedDriver!);

      // Perbarui urutan pengiriman dari hasil cekGoogle
      List<Kontak> sortedKontaks = cekGoogleResult.kontaks.map((customer) {
        return Kontak(
          displayName: customer.displayName,
          kontakID: customer.kontakID,
          type: customer.type,
          urutanPengiriman:
              customer.urutanPengiriman, // Urutan pengiriman yang diperbarui
          latitude: customer.latitude,
          lokasi: customer.lokasi,
          longitude: customer.longitude,
          nomorFaktur: int.tryParse(customer.nomorFaktur) ?? 0,
        );
      }).toList();

      // Tambahkan pelanggan yang tidak memiliki latitude/longitude di akhir urutan
      for (var customer in invalidCustomers) {
        sortedKontaks.add(Kontak(
          displayName: customer.displayName,
          kontakID: customer.kontakID,
          type: customer.type,
          urutanPengiriman:
              sortedKontaks.length + 1, // Tambahkan urutan di akhir
          latitude: 'Tidak ada',
          lokasi: customer.lokasi,
          longitude: 'Tidak ada',
          nomorFaktur: int.tryParse(customer.nomorFaktur) ?? 0,
        ));
      }

      // Buat objek SubmitPerjalananModel dengan kontak yang sudah diurutkan dan lengkap
      final submitPengantaranModel = SubmitPerjalananModel(
        googleMapsUrl: cekGoogleResult.googleMapsUrl,
        shiftKe: int.tryParse(_shiftController.text) ?? 0,
        jamPengiriman: _jamPengirimanController.text,
        jamKembali: _jamKembaliController.text,
        driverId: _selectedDriver?.karyawanID ?? 0,
        namaDriver: _selectedDriver?.nama ?? '',
        tipeKendaraan: _selectedVehicle?.tipe ?? '',
        nomorPolisiKendaraan: _selectedVehicle?.nomorPolisi ?? '',
        createdBy: _agentController.text,
        kontaks:
            sortedKontaks, // Kontak yang sudah diurutkan, termasuk yang tidak punya lokasi
        minDistance: cekGoogleResult.minDistance,
        minDuration: cekGoogleResult.minDuration,
      );

      // Submit pengantaran dengan kontak yang sudah diurutkan
      submitPerjalananBloc.add(SubmitPerjalanan(
        submitPerjalananModel: submitPengantaranModel,
      ));
    } catch (e) {
      // Tangani kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => submitPerjalananBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Diantar Jarak',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CustomColorPalette.textColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: CustomColorPalette.backgroundColor,
          actions: [
            IconButton(
              icon: Icon(Icons.history,
                  color: CustomColorPalette.buttonColor, size: 30),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryPengantaranPage()));
              },
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: BlocListener<SubmitPerjalananBloc, SubmitPerjalananState>(
          listener: (context, state) {
            if (state is PerjalananSubmitted) {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubmitResultPage(
                    submitPengantaranModel: state.detailPerjalanan,
                  ),
                ),
              );
            } else if (state is SubmitPerjalananError) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  // Expanded to take available height
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _getResponsiveMargin(context),
                        ),
                        child: Column(
                          children: [
                            if (constraints.maxWidth > 768)
                              _buildDesktopLayout()
                            else
                              _buildMobileLayout(),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Submit Button above Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => _submitData(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CustomColorPalette.buttonTextColor,
                        backgroundColor: CustomColorPalette.buttonColor,
                      ),
                      child: const Text('Submit'),
                    ),
                  ),

                  // Footer stays at the bottom
                  const SearchFooterWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildLeftColumn(),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _buildRightColumn(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildLeftColumn(),
        const SizedBox(height: 20),
        _buildRightColumn(),
      ],
    );
  }

  Widget _buildLeftColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownAgent(
          controller: _agentController,
          onAgentSelected: (agent) {
            setState(() {
              // Handle agent selected
            });
          },
        ),
        const SizedBox(height: 12),
        DropdownDriver(
          controller: _driverController,
          onPositionSelected: (position) {
            setState(() {
              // Handle position selected
            });
          },
          onDriverSelected: (driver) {
            setState(() {
              _selectedDriver = driver;
            });
          },
        ),
        const SizedBox(height: 12),
        DropdownShift(
          controller: _shiftController,
          onShiftSelected: (shift) {
            setState(() {
              // Handle shift selected
            });
          },
        ),
        const SizedBox(height: 12),
        DropdownTipeKendaraan(
          vehicleTypeController: _tipeKendaraanController,
          plateNumberController: _nomorPolisiKendaraanController,
          onTipeSelected: (tipe) {
            setState(() {
              _selectedVehicle = DropdownVehicleModel(
                tipe: _tipeKendaraanController.text,
                nomorPolisi: _nomorPolisiKendaraanController.text,
              );
            });
          },
          selectedDriver: _selectedDriver,
        ),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: _addCustomerDropdown,
            style: ElevatedButton.styleFrom(
              foregroundColor: CustomColorPalette.buttonTextColor,
              backgroundColor: CustomColorPalette.buttonColor,
            ),
            child: const Icon(Icons.add),
          ),
        ),
        const SizedBox(height: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _selectedCustomers.map((customer) {
            return _buildCustomerDropdown(customer);
          }).toList(),
        ),
        const SizedBox(height: 20),
        if (_selectedCustomers.isNotEmpty && _selectedDriver != null)
          ContainerCekGoogle(
            key: UniqueKey(),
            selectedCustomers: _selectedCustomers,
            selectedDriver: _selectedDriver!,
            cekGoogleService: cekGoogleService,
          ),
      ],
    );
  }
}
