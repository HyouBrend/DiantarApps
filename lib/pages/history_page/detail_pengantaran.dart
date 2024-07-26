import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_bloc.dart';
import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_event.dart';
import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_state.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPengantaranPage extends StatelessWidget {
  final String perjalananID;

  const DetailPengantaranPage({Key? key, required this.perjalananID})
      : super(key: key);

  Widget buildRow(String label, String? value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150, // Set width as per your need
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          Text(
            ":",
            style: TextStyle(
              fontSize: 18,
              color: CustomColorPalette.textColor,
            ),
          ),
          SizedBox(width: 8), // Space between label and value
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    value ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: CustomColorPalette.textColor,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<DetailPengantaranBloc>()
        .add(FetchDetailPengantaran(perjalananID));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Perjalanan',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF363535),
          ),
        ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Detail Pengiriman',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF363535),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Update'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ListTile(
                          title: Text(
                            capitalizeWords(
                                state.detailPengantaran[0].namaDriver),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              buildRow(
                                  'Shift',
                                  state.detailPengantaran[0].shiftKe
                                      .toString()),
                              buildRow('Jam Pengiriman',
                                  state.detailPengantaran[0].jamPengiriman),
                              buildRow('Jam Kembali',
                                  state.detailPengantaran[0].jamKembali),
                              buildRow('Tipe Kendaraan',
                                  state.detailPengantaran[0].tipeKendaraan),
                              buildRow(
                                  'Nomor Polisi Kendaraan',
                                  state.detailPengantaran[0]
                                      .nomorPolisiKendaraan),
                              buildRow('Created By',
                                  state.detailPengantaran[0].createdBy),
                              buildRow('Created Date',
                                  '${state.detailPengantaran[0].createdDate}'),
                            ],
                          ),
                        ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Detail Customers',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF363535),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Implementasi logika untuk update
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: state.detailPengantaran.map((detail) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    detail.displayName ?? 'N/A',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColorPalette.textColor,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildRow('Kontak ID', detail.kontakID),
                                      buildRow('Type', detail.posisi),
                                      buildRow('Urutan Pengiriman',
                                          detail.urutanPengiriman.toString()),
                                      buildRow('Latitude',
                                          detail.inputLatitude.toString(),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.location_on,
                                              size: 30,
                                              color: Color(0xFF8A2BE2),
                                            ),
                                            onPressed: () {
                                              // Open Google Maps URL
                                              if (detail.inputLatitude !=
                                                      null &&
                                                  detail.inputLongitude !=
                                                      null) {
                                                launch(
                                                    'https://www.google.com/maps/search/?api=1&query=${detail.inputLatitude},${detail.inputLongitude}');
                                              }
                                            },
                                          )),
                                      buildRow('Longitude',
                                          detail.inputLongitude.toString()),
                                      buildRow('Lokasi', detail.lokasi),
                                      buildRow('Nomor Faktur',
                                          detail.nomorFaktur.toString()),
                                      const Divider(color: Colors.purple),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Google Maps',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF363535),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  buildRow('Min Distance',
                                      '${state.detailPengantaran[0].minJarakPengiriman?.toStringAsFixed(2)} km'),
                                  buildRow('Min Duration',
                                      '${state.detailPengantaran[0].minDurasiPengiriman?.toStringAsFixed(2)} minutes'),
                                  buildRow('Update By',
                                      '${state.detailPengantaran[0].updateBy} (${state.detailPengantaran[0].updateAt})'),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.map_rounded,
                                size: 30,
                                color: Color(0xFF8A2BE2),
                              ),
                              onPressed: () {
                                // Open Google Maps URL
                                if (state.detailPengantaran[0].googleMapsURL !=
                                        null &&
                                    state.detailPengantaran[0].googleMapsURL!
                                        .isNotEmpty) {
                                  launch(state
                                      .detailPengantaran[0].googleMapsURL!);
                                }
                              },
                            ),
                          ],
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
