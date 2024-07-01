import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCustomer extends StatelessWidget {
  final String agentName;
  final String driverName;
  final String vehicleType;
  final String plateNumber;
  final List<DropdownCustomerModel> customers;

  const DetailCustomer({
    Key? key,
    required this.agentName,
    required this.driverName,
    required this.vehicleType,
    required this.plateNumber,
    required this.customers,
  }) : super(key: key);

  void _openGoogleMaps(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 10),
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

      // Buat URL Google Maps dengan beberapa koordinat
      if (customers.isNotEmpty) {
        String googleMapsUrl = "https://www.google.com/maps/dir";
        for (var customer in customers) {
          googleMapsUrl += "/${customer.latitude},${customer.longitude}";
        }
        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengiriman'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Checker: $agentName',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Nama Driver: $driverName',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Tipe Kendaraan: "$vehicleType ($plateNumber)"',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: customers.map((customer) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nama: ${customer.displayName ?? ''}",
                              style: TextStyle(fontSize: 16)),
                          Text("Lokasi: ${customer.lokasi ?? ''}",
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: CustomColorPalette.BgBorder,
              border: Border.all(color: CustomColorPalette.textColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tautan ke Google Maps:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  "Klik tombol di bawah untuk memeriksa Google Maps.",
                  style: TextStyle(color: CustomColorPalette.textColor),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _openGoogleMaps(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: CustomColorPalette.buttonTextColor,
                      backgroundColor: CustomColorPalette.buttonColor,
                    ),
                    child: Text('Cek Google Maps'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
