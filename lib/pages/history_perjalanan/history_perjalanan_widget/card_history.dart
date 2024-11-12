import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/history_perjalanan_model/history_perjalanan_model.dart';
import 'package:diantar_jarak/pages/detail_perjalanan/detail_pengantaran.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardHistory extends StatelessWidget {
  final HistoryPengantaranModel historyItem;

  const CardHistory({super.key, required this.historyItem});

  // Fungsi untuk menentukan ukuran font yang responsif
  double getFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1024) {
      return baseSize; // Ukuran font untuk desktop
    } else if (screenWidth > 768 && screenWidth <= 1024) {
      return baseSize - 4; // Ukuran font lebih kecil untuk tablet
    } else {
      return baseSize - 8; // Ukuran font lebih kecil untuk mobile
    }
  }

  String _validateTime(String time) {
    if (time == 'Mon, 01 Jan 1900 00:00:00 GMT') {
      return 'Perlu di update';
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryPengantaranBloc, HistoryPengantaranState>(
      builder: (context, state) {
        HistoryPengantaranModel currentHistoryItem = historyItem;

        if (state is HistoryLoaded) {
          final updatedHistoryItem = state.histories.firstWhere(
              (history) => history.perjalananId == historyItem.perjalananId,
              orElse: () => historyItem);
          currentHistoryItem = updatedHistoryItem;
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPengantaranPage(
                    perjalananID: historyItem.perjalananId,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: CustomColorPalette.BgBorder,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelPink,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            capitalizeWords(historyItem.namaDriver),
                            style: TextStyle(
                              fontSize: getFontSize(context, 24),
                              fontWeight: FontWeight.bold,
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                        SizedBox(height: Sizes.dp8(context)),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelBlue,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Create By: ${historyItem.createdBy}',
                            style: TextStyle(
                              fontSize: getFontSize(context, 20),
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelYellow,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Jam Pengiriman: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: getFontSize(context, 18),
                                    color: CustomColorPalette.textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: _validateTime(
                                      currentHistoryItem.jamPengiriman),
                                  style: TextStyle(
                                    fontSize: getFontSize(context, 18),
                                    color: CustomColorPalette.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelOrange,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${historyItem.minDurasiPengiriman} menit',
                                style: TextStyle(
                                  fontSize: getFontSize(context, 18),
                                  color: CustomColorPalette.textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${historyItem.minJarakPengiriman} km',
                                style: TextStyle(
                                  fontSize: getFontSize(context, 18),
                                  color: CustomColorPalette.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.mintCream,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Jam Kembali: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: getFontSize(context, 18),
                                    color: CustomColorPalette.textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: _validateTime(
                                      currentHistoryItem.jamKembali),
                                  style: TextStyle(
                                    fontSize: getFontSize(context, 18),
                                    color: CustomColorPalette.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelGray,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            historyItem.tipeKendaraan,
                            style: TextStyle(
                              fontSize: getFontSize(context, 18),
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.lavender,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'Shift ke-${historyItem.shiftKe}',
                            style: TextStyle(
                              fontSize: getFontSize(context, 18),
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: getStatusColor(currentHistoryItem.status),
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            getStatusLabel(currentHistoryItem.status),
                            style: TextStyle(
                              fontSize: getFontSize(context, 18),
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk mendapatkan warna status
  Color getStatusColor(String status) {
    switch (status) {
      case 'Sudah Dikirim':
        return CustomColorPalette.SudahDikirimStats;
      case 'Belum Dikirim':
        return CustomColorPalette.BelumDikirimStats;
      case 'Selesai':
        return CustomColorPalette.SelesaiStats;
      case 'Tidak Dikirim':
        return CustomColorPalette.TidakDikirimStats;
      case 'Salah Input':
        return CustomColorPalette.SalahInputStats;
      default:
        return Colors.grey;
    }
  }

  // Fungsi untuk mendapatkan label status
  String getStatusLabel(String status) {
    switch (status) {
      case 'Sudah Dikirim':
        return 'Sudah Dikirim';
      case 'Belum Dikirim':
        return 'Belum Dikirim';
      case 'Selesai':
        return 'Selesai';
      case 'Tidak Dikirim':
        return 'Tidak Dikirim';
      case 'Salah Input':
        return 'Salah Input';
      default:
        return 'Unknown';
    }
  }
}
