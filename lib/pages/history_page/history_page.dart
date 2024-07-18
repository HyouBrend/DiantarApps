import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_bloc.dart';
import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_event.dart';
import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_state.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPengantaranPage extends StatelessWidget {
  final String perjalananID;

  const DetailPengantaranPage({Key? key, required this.perjalananID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<DetailPengantaranBloc>()
        .add(FetchDetailPengantaran(perjalananID: perjalananID));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengiriman'),
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: BlocBuilder<DetailPengantaranBloc, DetailPengantaranState>(
        builder: (context, state) {
          if (state is DetailPengantaranLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DetailPengantaranLoaded) {
            // Sort the detailPengantaran list by urutanPengiriman
            state.detailPengantaran.sort(
                (a, b) => a.urutanPengiriman.compareTo(b.urutanPengiriman));

            return Padding(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Detail Driver',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implementasi logika untuk update
                                    },
                                    child: const Text('Update'),
                                  ),
                                ],
                              ),
                              Text(
                                  'Shift: ${state.detailPengantaran[0].shiftKe}'),
                              Text(
                                  'Jam Pengiriman: ${state.detailPengantaran[0].jamPengiriman}'),
                              Text(
                                  'Jam Kembali: ${state.detailPengantaran[0].jamKembali}'),
                              Text(
                                  'Driver ID: ${state.detailPengantaran[0].driverID}'),
                              Text(
                                  'Nama Driver: ${state.detailPengantaran[0].namaDriver}'),
                              Text(
                                  'Tipe Kendaraan: ${state.detailPengantaran[0].tipeKendaraan}'),
                              Text(
                                  'Nomor Polisi Kendaraan: ${state.detailPengantaran[0].nomorPolisiKendaraan}'),
                              Text(
                                  'Created By: ${state.detailPengantaran[0].createdBy}'),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Customers',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Implementasi logika untuk update
                                    },
                                    child: const Text('Update'),
                                  ),
                                ],
                              ),
                              ...state.detailPengantaran.map((detail) {
                                return ListTile(
                                  title: Text(detail.displayName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Kontak ID: ${detail.kontakID}'),
                                      Text('Type: ${detail.posisi}'),
                                      Text(
                                          'Urutan Pengiriman: ${detail.urutanPengiriman}'),
                                      Text('Latitude: ${detail.inputLatitude}'),
                                      Text('Lokasi: ${detail.lokasi}'),
                                      Text(
                                          'Longitude: ${detail.inputLongitude}'),
                                      Text(
                                          'Nomor Faktur: ${detail.nomorFaktur}'),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(bottom: 16.0),
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
                              const Text(
                                'Cek Google Maps',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Min Distance: ${state.detailPengantaran[0].minJarakPengiriman.toStringAsFixed(2)} km',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Min Duration: ${state.detailPengantaran[0].minDurasiPengiriman.toStringAsFixed(2)} minutes',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Open Google Maps URL
                                    if (state.detailPengantaran[0]
                                            .googleMapsURL !=
                                        null) {
                                      launch(state
                                          .detailPengantaran[0].googleMapsURL);
                                    }
                                  },
                                  child: const Text('Open in Google Maps'),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Update By: ${state.detailPengantaran[0].updateBy} (${state.detailPengantaran[0].updateAt})',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${state.detailPengantaran[0].createdDate}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DetailPengantaranError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
