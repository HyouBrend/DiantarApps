import 'package:diantar_jarak/pages/search_page/search_page.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_result/submit_pengantaran_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmitResultPage extends StatelessWidget {
  final SubmitPengantaranModel submitPengantaranModel;
  final DateTime waktuPesanan;

  const SubmitResultPage({
    Key? key,
    required this.submitPengantaranModel,
    required this.waktuPesanan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengiriman'),
        backgroundColor: CustomColorPalette.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail Driver',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Shift: ${submitPengantaranModel.shiftKe}'),
                        Text(
                            'Jam Pengiriman: ${submitPengantaranModel.jamPengiriman ?? ''}'),
                        Text(
                            'Jam Kembali: ${submitPengantaranModel.jamKembali ?? ''}'),
                        Text('Driver ID: ${submitPengantaranModel.driverId}'),
                        Text(
                            'Nama Driver: ${submitPengantaranModel.namaDriver}'),
                        Text(
                            'Tipe Kendaraan: ${submitPengantaranModel.tipeKendaraan}'),
                        Text(
                            'Nomor Polisi Kendaraan: ${submitPengantaranModel.nomorPolisiKendaraan}'),
                        Text('Created By: ${submitPengantaranModel.createdBy}'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Customers',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ...submitPengantaranModel.kontaks.map((kontak) {
                          return ListTile(
                            title: Text(kontak.displayName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kontak ID: ${kontak.kontakID}'),
                                Text('Type: ${kontak.type}'),
                                Text(
                                    'Urutan Pengiriman: ${kontak.urutanPengiriman}'),
                                Text('Latitude: ${kontak.latitude}'),
                                Text('Lokasi: ${kontak.lokasi}'),
                                Text('Longitude: ${kontak.longitude}'),
                                Text('Nomor Faktur: ${kontak.nomorFaktur}'),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cek Google Maps',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Min Distance: ${submitPengantaranModel.minDistance.toStringAsFixed(2)} km',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Min Duration: ${submitPengantaranModel.minDuration.toStringAsFixed(2)} minutes',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Open Google Maps URL
                              if (submitPengantaranModel.googleMapsUrl !=
                                  null) {
                                launch(submitPengantaranModel.googleMapsUrl!);
                              }
                            },
                            child: const Text('Open in Google Maps'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Waktu Pesanan: $waktuPesanan',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
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
