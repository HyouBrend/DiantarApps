import 'package:diantar_jarak/bloc/search_page/submit/submit_event.dart';
import 'package:diantar_jarak/bloc/search_page/submit/submit_state.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/columnlistcustomer.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/bloc/search_page/submit/submit_bloc.dart';
import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';
import 'package:diantar_jarak/data/service/result_page_service.dart/detail_pengantaran_service.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page.dart';
import 'package:diantar_jarak/pages/result_page/detail_customer.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/search_page_service/cek_google_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_widget/dropdown_customer.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_widget/dropdown_agent.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_widget/dropdown_driver.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_widget/dropdown_shift.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_widget/dropdown_tipekendaraan.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _googleMapsUrlController =
      TextEditingController();
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _jamPengirimanController =
      TextEditingController();
  final TextEditingController _jamKembaliController = TextEditingController();
  final TextEditingController _tipeKendaraanController =
      TextEditingController();
  final TextEditingController _nomorPolisiKendaraanController =
      TextEditingController();
  final TextEditingController _createdByController = TextEditingController();
  final TextEditingController _minDistanceController = TextEditingController();
  final TextEditingController _minDurationController = TextEditingController();
  final TextEditingController _agentController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  DropdownDriveModel? _selectedDriver;
  DropdownVehicleModel? _selectedVehicle;
  List<DropdownCustomerModel> _selectedCustomers = [];

  late final ApiHelper apiHelper;
  late final SubmitPengantaranService submitPengantaranService;
  late final CekGoogleService cekGoogleService;

  _SearchPageState() {
    apiHelper = ApiHelperImpl(dio: Dio());
    submitPengantaranService = SubmitPengantaranService(apiHelper: apiHelper);
    cekGoogleService = CekGoogleService(apiHelper: apiHelper);
  }

  void _openGoogleMaps(BuildContext context) async {
    try {
      if (_selectedCustomers.isNotEmpty && _selectedDriver != null) {
        final result = await cekGoogleService.cekGoogle(
            _selectedCustomers, _selectedDriver!);

        String googleMapsUrl = result.googleMapsUrl;
        if (await canLaunch(googleMapsUrl)) {
          await launch(
            googleMapsUrl,
            forceSafariVC: false,
            forceWebView: false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $googleMapsUrl')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _submitPengantaran() {
    try {
      if (_selectedDriver != null && _selectedCustomers.isNotEmpty) {
        final detailPengantaran = DetailPengantaranModel(
          googleMapsUrl: _googleMapsUrlController.text,
          shiftKe: int.tryParse(_shiftController.text) ?? 0,
          jamPengiriman: _jamPengirimanController.text,
          jamKembali: _jamKembaliController.text,
          driverId: _selectedDriver?.karyawanID ?? 0,
          namaDriver: _selectedDriver?.nama ?? '',
          tipeKendaraan: _tipeKendaraanController.text,
          nomorPolisiKendaraan: _nomorPolisiKendaraanController.text,
          createdBy: _createdByController.text,
          kontaks: _selectedCustomers
              .map((customer) => customer.toKontak())
              .toList(),
          minDistance: double.tryParse(_minDistanceController.text) ?? 0.0,
          minDuration: double.tryParse(_minDurationController.text) ?? 0.0,
        );

        context
            .read<SubmitBloc>()
            .add(SubmitPengantaranEvent(detailPengantaran));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a driver and customers')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  double? _parseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      print('Invalid double: $value');
      return null;
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                SizedBox(width: 10),
                const Text("DATA SEDANG DALAM PROSES",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addCustomerDropdown() {
    setState(() {
      _selectedCustomers
          .add(DropdownCustomerModel(kontakID: UniqueKey().toString()));
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
                key: ValueKey(customer.kontakID),
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
            SizedBox(width: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () => _removeCustomerDropdown(customer),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Icon(Icons.remove),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitPengantaran,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
        ),
        child: const Text('Submit'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubmitBloc, SubmitState>(
      listener: (context, state) {
        if (state is SubmitSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCustomer(
                googleMapsUrl: state.response.googleMapsUrl,
                shiftKe: state.response.shiftKe.toString(),
                jamPengiriman: state.response.jamPengiriman,
                jamKembali: state.response.jamKembali,
                driverId: state.response.driverId,
                namaDriver: state.response.namaDriver,
                tipeKendaraan: state.response.tipeKendaraan,
                nomorPolisiKendaraan: state.response.nomorPolisiKendaraan,
                createdBy: state.response.createdBy,
                kontaks: state.response.kontaks
                    .map((kontak) => DropdownCustomerModel.fromKontak(kontak))
                    .toList(),
                minDistance: state.response.minDistance,
                minDuration: state.response.minDuration,
                responseData: state.response.toJson(),
                submitPengantaranService:
                    context.read<SubmitPengantaranService>(),
              ),
            ),
          );
        } else if (state is SubmitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Diantar Jarak',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: Icon(Icons.history, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListHistoryPage()));
              },
            ),
            SizedBox(width: 4),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
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
                                    vehicleTypeController:
                                        _tipeKendaraanController,
                                    plateNumberController:
                                        _nomorPolisiKendaraanController,
                                    onTipeSelected: (tipe) {
                                      setState(() {
                                        _selectedVehicle = DropdownVehicleModel(
                                          tipe: _tipeKendaraanController.text,
                                          nomorPolisi:
                                              _nomorPolisiKendaraanController
                                                  .text,
                                        );
                                      });
                                    },
                                    selectedDriver: _selectedDriver,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: _addCustomerDropdown,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),
                          SizedBox(height: 4),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _selectedCustomers.map((customer) {
                                  return _buildCustomerDropdown(customer);
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (_selectedCustomers.isNotEmpty &&
                              _selectedDriver != null)
                            Expanded(
                              child: ColumnCustomerList(
                                key: UniqueKey(),
                                selectedCustomers: _selectedCustomers,
                                selectedDriver: _selectedDriver!,
                                cekGoogleService: cekGoogleService,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitPengantaran,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
