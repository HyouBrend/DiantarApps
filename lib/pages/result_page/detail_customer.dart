import 'package:diantar_jarak/data/models/model_page_search/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/result_page_service.dart/detail_pengantaran_service.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCustomer extends StatelessWidget {
  final String googleMapsUrl;
  final String shiftKe;
  final String jamPengiriman;
  final String jamKembali;
  final int driverId;
  final String namaDriver;
  final String tipeKendaraan;
  final String nomorPolisiKendaraan;
  final String createdBy;
  final List<DropdownCustomerModel> kontaks;
  final double minDistance;
  final double minDuration;
  final Map<String, dynamic> responseData;
  final SubmitPengantaranService submitPengantaranService;

  const DetailCustomer({
    Key? key,
    required this.googleMapsUrl,
    required this.shiftKe,
    required this.jamPengiriman,
    required this.jamKembali,
    required this.driverId,
    required this.namaDriver,
    required this.tipeKendaraan,
    required this.nomorPolisiKendaraan,
    required this.createdBy,
    required this.kontaks,
    required this.minDistance,
    required this.minDuration,
    required this.responseData,
    required this.submitPengantaranService,
  }) : super(key: key);

  void _openGoogleMaps(BuildContext context) async {
    try {
      if (googleMapsUrl.isNotEmpty) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengiriman',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildDetailSection('Detail Pengantaran', [
                _buildDetailItem('Shift Ke', shiftKe),
                _buildDetailItem('Nama Driver', namaDriver),
                _buildDetailItem('Tipe Kendaraan', tipeKendaraan),
                _buildDetailItem(
                    'Nomor Polisi Kendaraan', nomorPolisiKendaraan),
                _buildDetailItem('Jam Pengiriman', jamPengiriman),
                _buildDetailItem('Jam Kembali', jamKembali),
                _buildDetailItem('Created By', createdBy),
                _buildDetailItem(
                    'Minimum Distance', '${minDistance.toStringAsFixed(2)} km'),
                _buildDetailItem('Minimum Duration',
                    '${minDuration.toStringAsFixed(2)} minutes'),
              ]),
              _buildDetailSection(
                  'Detail Customer',
                  kontaks.map((customer) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailItem('Nama', customer.displayName ?? ''),
                        _buildDetailItem('Lokasi', customer.lokasi ?? ''),
                      ],
                    );
                  }).toList()),
              _buildDetailSection('Google Maps', [
                Text(
                  'Klik tombol di bawah untuk melihat lokasi customer di Google Maps.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () => _openGoogleMaps(context),
                  child: Text('Buka di Google Maps',
                      style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: CustomColorPalette.buttonTextColor,
                    backgroundColor: CustomColorPalette.buttonColor,
                    textStyle: TextStyle(
                        decoration: TextDecoration.none), // No underline text
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CustomColorPalette.BgBorder,
        border: Border.all(color: CustomColorPalette.textColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
