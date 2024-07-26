import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_state.dart';
import 'package:diantar_jarak/pages/history_page/detail_pengantaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:diantar_jarak/util/size.dart';

class CardHistory extends StatelessWidget {
  final HistoryPengantaranModel historyItem;

  const CardHistory({Key? key, required this.historyItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListHistoryBloc, ListHistoryState>(
      builder: (context, state) {
        HistoryPengantaranModel currentHistoryItem = historyItem;

        if (state is ListHistoryLoaded) {
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
                    perjalananID: currentHistoryItem.perjalananId,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
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
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelPink,
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            capitalizeWords(currentHistoryItem.namaDriver),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Sizes.dp8(context),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelBlue,
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Create By: ' + currentHistoryItem.createdBy,
                            style: TextStyle(
                              fontSize: 20,
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelYellow,
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Jam Pengiriman: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: CustomColorPalette.textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: currentHistoryItem.jamPengiriman,
                                  style: TextStyle(
                                    fontSize: 18,
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
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 18,
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelOrange,
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${currentHistoryItem.minDurasiPengiriman} menit',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CustomColorPalette.textColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${currentHistoryItem.minJarakPengiriman} km',
                                style: TextStyle(
                                  fontSize: 18,
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
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.mintCream,
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Jam Kembali: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: CustomColorPalette.textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: currentHistoryItem.jamKembali,
                                  style: TextStyle(
                                    fontSize: 18,
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
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.pastelGray,
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            currentHistoryItem.tipeKendaraan,
                            style: TextStyle(
                              fontSize: 18,
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColorPalette.lavender,
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Shift ke-${currentHistoryItem.shiftKe}',
                            style: TextStyle(
                              fontSize: 18,
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: getStatusColor(currentHistoryItem.status),
                            border: Border.all(
                                color: Colors.black), // Border hitam tipis
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            getStatusLabel(currentHistoryItem.status),
                            style: TextStyle(
                              fontSize: 18,
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'Sudah Dikirim':
        return CustomColorPalette.SudahDikirimStats;
      case 'Belum Dikirim':
        return CustomColorPalette.BelumDikirimStats;
      case 'Tidak Dikirim':
        return CustomColorPalette.TidakDikirimStats;
      case 'Salah Input':
        return CustomColorPalette.SalahInputStats;
      default:
        return Colors.grey;
    }
  }

  String getStatusLabel(String status) {
    switch (status) {
      case 'Sudah Dikirim':
        return 'Sudah Dikirim';
      case 'Belum Dikirim':
        return 'Belum Dikirim';
      case 'Tidak Dikirim':
        return 'Tidak Dikirim';
      case 'Salah Input':
        return 'Salah Input';
      default:
        return 'Unknown';
    }
  }
}
