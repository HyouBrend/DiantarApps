import 'package:diantar_jarak/data/models/model_page_search/cek_google_model.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/search_page_service/cek_google_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/size.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_agent.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_driver.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_customer.dart';
import 'package:diantar_jarak/pages/search_page/search_page_widget/dropdown_tipekendaraan.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _agentController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  String? _agent;
  String? _driverPosition;
  String? _vehicleType;
  DropdownDriveModel? _selectedDriver;
  final ApiHelper apiHelper = ApiHelperImpl(dio: Dio());
  List<DropdownCustomerModel> _selectedCustomers = [];

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(Sizes.dp16(context)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: Sizes.dp10(context)),
                Text(
                  "DATA SEDANG DALAM PROSES",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addCustomerDropdown() {
    setState(() {
      _selectedCustomers.add(DropdownCustomerModel());
    });
  }

  void _removeCustomerDropdown(DropdownCustomerModel customer) {
    setState(() {
      _selectedCustomers.remove(customer);
    });
  }

  void _openGoogleMaps() async {
    try {
      _showLoadingDialog(context);

      // Buat daftar KontakModel dari _selectedCustomers
      List<KontakModel> kontakModels = _selectedCustomers.map((customer) {
        return KontakModel(
          kontakID: customer.kontakID ?? '',
          displayName: customer.displayName ?? '',
          type: customer.type ?? '',
          lokasi: customer.lokasi ?? '',
          latitude: customer.latitude ?? '',
          longitude: customer.longitude ?? '',
        );
      }).toList();

      // Buat CekGoogleModel
      CekGoogleModel cekGoogleModel = CekGoogleModel(
        karyawanID: _selectedDriver?.karyawanID ?? 0,
        nama: _selectedDriver?.nama ?? '',
        posisi: _selectedDriver?.posisi ?? '',
        noHP: _selectedDriver?.noHP ?? '',
        kontaks: kontakModels,
      );

      final cekGoogleService = CekGoogleService(apiHelper: apiHelper);
      final result = await cekGoogleService.cekGoogle(cekGoogleModel);
      Navigator.pop(context);

      // Buat URL Google Maps dengan beberapa koordinat
      if (_selectedCustomers.isNotEmpty) {
        String googleMapsUrl = "https://www.google.com/maps/dir";
        for (var customer in _selectedCustomers) {
          googleMapsUrl += "/${customer.latitude},${customer.longitude}";
        }
        if (await canLaunch(googleMapsUrl)) {
          await launch(
            googleMapsUrl,
            forceSafariVC: false,
            forceWebView: false,
          );
        } else {
          throw 'Could not launch $googleMapsUrl';
        }
      }
    } catch (e) {
      Navigator.pop(context);
      print('Error: $e');
    }
  }

  Widget _buildCustomerDropdown(DropdownCustomerModel customer) {
    return Column(
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
            SizedBox(width: Sizes.dp4(context)),
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

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle submit action
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: CustomColorPalette.buttonTextColor,
          backgroundColor: CustomColorPalette.buttonColor,
        ),
        child: Text('Submit'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diantar Jarak',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: CustomColorPalette.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: CustomColorPalette.textColor),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListHistoryPage()));
            },
          ),
          SizedBox(width: Sizes.dp4(context)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.dp16(context)),
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
                                _agent = agent;
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          DropdownDriver(
                            controller: _driverController,
                            onPositionSelected: (position) {
                              setState(() {
                                _driverPosition = position;
                              });
                            },
                            onDriverSelected: (driver) {
                              setState(() {
                                _selectedDriver = driver;
                              });
                            },
                          ),
                          SizedBox(height: 12),
                          DropdownTipeKendaraan(
                            controller: _vehicleTypeController,
                            onTipeSelected: (tipe) {
                              setState(() {
                                _vehicleType = tipe;
                              });
                            },
                            selectedDriver: _selectedDriver,
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Sizes.dp4(context)),
            Expanded(
              child: Column(
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
                  SizedBox(height: Sizes.dp4(context)),
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
                  SizedBox(
                    height: 20,
                  ),
                  if (_selectedCustomers.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.BgBorder,
                            border:
                                Border.all(color: CustomColorPalette.textColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(Sizes.dp4(context)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tautan ke Google Maps:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Klik tombol di bawah untuk memeriksa Google Maps.",
                                style: TextStyle(
                                    color: CustomColorPalette.textColor),
                              ),
                              ..._selectedCustomers.map((customer) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Sizes.dp4(context)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama: ${customer.displayName ?? 'N/A'}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Lokasi: ${customer.lokasi ?? 'N/A'}",
                                        style: TextStyle(
                                            color:
                                                CustomColorPalette.textColor),
                                      ),
                                      Text(
                                        "Latitude: ${customer.latitude ?? 'N/A'}, Longitude: ${customer.longitude ?? 'N/A'}",
                                        style: TextStyle(
                                            color:
                                                CustomColorPalette.textColor),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              Center(
                                child: ElevatedButton(
                                  onPressed: _openGoogleMaps,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        CustomColorPalette.buttonTextColor,
                                    backgroundColor:
                                        CustomColorPalette.buttonColor,
                                  ),
                                  child: Text('Cek Google Maps'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
