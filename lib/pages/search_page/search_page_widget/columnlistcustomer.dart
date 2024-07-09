import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/search_page_service/cek_google_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ColumnCustomerList extends StatelessWidget {
  final List<DropdownCustomerModel> selectedCustomers;
  final DropdownDriveModel selectedDriver;
  final CekGoogleService cekGoogleService;

  ColumnCustomerList({
    Key? key,
    required this.selectedCustomers,
    required this.selectedDriver,
    required this.cekGoogleService,
  }) : super(key: key);

  void _openGoogleMaps(BuildContext context) async {
    try {
      if (selectedCustomers.isNotEmpty) {
        final result =
            await cekGoogleService.cekGoogle(selectedCustomers, selectedDriver);

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cekGoogleService.cekGoogle(selectedCustomers, selectedDriver),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final result = snapshot.data;
          final sortedCustomers = result.kontaks;

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: CustomColorPalette.BgBorder,
                border: Border.all(
                  color: CustomColorPalette.textColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nama: ${selectedDriver.nama}',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Min Distance: ${result.minDistance.toStringAsFixed(2)} km',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Min Duration: ${result.minDuration.toStringAsFixed(2)} minutes',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'List Customer:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...sortedCustomers.map((customer) {
                    return Column(
                      key: ValueKey(customer.kontakID), // Ensure unique key
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama: ${customer.displayName}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Alamat: ${customer.lokasi}',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Divider(color: Colors.purple),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _openGoogleMaps(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CustomColorPalette.buttonTextColor,
                        backgroundColor: CustomColorPalette.buttonColor,
                      ),
                      child: Text('Cek Maps'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }
        return Center(child: Text('No data available'));
      },
    );
  }
}
