import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/cek_google_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ContainerCekGoogle extends StatelessWidget {
  final List<DropdownCustomerModel> selectedCustomers;
  final DropdownDriveModel selectedDriver;
  final CekGoogleService cekGoogleService;

  const ContainerCekGoogle({
    super.key,
    required this.selectedCustomers,
    required this.selectedDriver,
    required this.cekGoogleService,
  });

  // Membuka Google Maps hanya dengan pelanggan yang memiliki lokasi valid
  void _openGoogleMaps(BuildContext context) async {
    try {
      final validCustomers = selectedCustomers
          .where((customer) => customer.hasValidLocation())
          .toList();

      if (validCustomers.isNotEmpty) {
        final result =
            await cekGoogleService.cekGoogle(validCustomers, selectedDriver);

        String googleMapsUrl = result.googleMapsUrl;
        if (await canLaunch(googleMapsUrl)) {
          await launch(googleMapsUrl,
              forceSafariVC: false, forceWebView: false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $googleMapsUrl')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No valid locations to check on Google Maps')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Fungsi untuk membuat baris dengan label dan value
  Widget buildRow(String label, String value, BuildContext context) {
    double getLabelWidth(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 1024) {
        return 150; // Lebar label untuk desktop
      } else if (screenWidth > 768 && screenWidth <= 1024) {
        return 130; // Lebar label untuk tablet
      } else {
        return 100; // Lebar label lebih kecil untuk mobile
      }
    }

    double getFontSize(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > 1024) {
        return 16; // Ukuran font untuk desktop
      } else if (screenWidth > 768 && screenWidth <= 1024) {
        return 14; // Ukuran font untuk tablet
      } else {
        return 12; // Ukuran font lebih kecil untuk mobile
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: getLabelWidth(context), // Lebar label responsif
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getFontSize(context),
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            ":",
            style: TextStyle(
                fontSize: getFontSize(context),
                color: CustomColorPalette.textColor),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                  fontSize: getFontSize(context),
                  color: CustomColorPalette.textColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cekGoogleService.cekGoogle(selectedCustomers, selectedDriver),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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
                border: Border.all(color: CustomColorPalette.textColor),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Driver',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  buildRow(
                      'Nama', capitalizeWords(selectedDriver.nama!), context),
                  const SizedBox(height: 20),
                  const Text(
                    'List Customer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...sortedCustomers.map((customer) {
                    return Column(
                      key: ValueKey(customer.kontakID), // Ensure unique key
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRow('Nama', customer.displayName, context),
                        buildRow('Alamat', customer.lokasi, context),
                        buildRow('Urutan Pengiriman',
                            customer.urutanPengiriman.toString(), context),
                        if (!customer.hasValidLocation())
                          const Text(
                            'Pelanggan ini tidak memiliki latitude/longitude',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        buildRow(
                            'Latitude',
                            customer.latitude.isEmpty
                                ? 'Tidak tersedia'
                                : customer.latitude,
                            context),
                        buildRow(
                            'Longitude',
                            customer.longitude.isEmpty
                                ? 'Tidak tersedia'
                                : customer.longitude,
                            context),
                        const Divider(color: Colors.purple),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  buildRow('Min Distance',
                      '${result.minDistance.toStringAsFixed(2)} km', context),
                  buildRow(
                      'Min Duration',
                      '${result.minDuration.toStringAsFixed(2)} minutes',
                      context),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _openGoogleMaps(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CustomColorPalette.buttonTextColor,
                        backgroundColor: CustomColorPalette.buttonColor,
                      ),
                      child: const Text('Cek Maps'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('No data available'));
      },
    );
  }
}
