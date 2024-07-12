import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_page_result/detail_pengantaran_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmitResultPage extends StatelessWidget {
  final DetailPengantaran detailPengantaran;

  const SubmitResultPage({Key? key, required this.detailPengantaran})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengiriman'),
        backgroundColor: CustomColorPalette.backgroundColor,
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
                        Text('Shift: ${detailPengantaran.shiftKe}'),
                        Text(
                            'Jam Pengiriman: ${detailPengantaran.jamPengiriman}'),
                        Text('Jam Kembali: ${detailPengantaran.jamKembali}'),
                        Text('Driver ID: ${detailPengantaran.driverId}'),
                        Text('Nama Driver: ${detailPengantaran.namaDriver}'),
                        Text(
                            'Tipe Kendaraan: ${detailPengantaran.tipeKendaraan}'),
                        Text(
                            'Nomor Polisi Kendaraan: ${detailPengantaran.nomorPolisiKendaraan}'),
                        Text('Created By: ${detailPengantaran.createdBy}'),
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
                          'Kontaks',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ...detailPengantaran.kontaks.map((kontak) {
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
                          'Summary',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Min Distance: ${detailPengantaran.minDistance.toStringAsFixed(2)} km',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Min Duration: ${detailPengantaran.minDuration.toStringAsFixed(2)} minutes',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Open Google Maps URL
                              if (detailPengantaran.googleMapsUrl != null) {
                                launch(detailPengantaran.googleMapsUrl!);
                              }
                            },
                            child: const Text('Open in Google Maps'),
                          ),
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
