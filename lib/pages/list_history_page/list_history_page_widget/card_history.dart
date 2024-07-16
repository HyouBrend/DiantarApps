import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'package:diantar_jarak/pages/history_page/history_page.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:diantar_jarak/util/format_date.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';

class CardHistory extends StatelessWidget {
  final HistoryPengantaranModel historyItem;

  const CardHistory({Key? key, required this.historyItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryPage(historyItem: historyItem),
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        capitalizeWords(historyItem.namaDriver),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CustomColorPalette.textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColorPalette.pastelBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        historyItem.createdBy,
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColorPalette.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColorPalette.pastelYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        historyItem.jamPengiriman != null
                            ? formatDate(historyItem.jamPengiriman!)
                            : '',
                        style: TextStyle(
                          fontSize: 14,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomColorPalette.textColor,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColorPalette.pastelOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            historyItem.minDurasiPengiriman.toString() +
                                ' menit',
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColorPalette.textColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            historyItem.minJarakPengiriman.toString() + ' km',
                            style: TextStyle(
                              fontSize: 14,
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
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColorPalette.mintCream,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        historyItem.jamKembali != null
                            ? formatDate(historyItem.jamKembali!)
                            : '',
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColorPalette.textColor,
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        historyItem.tipeKendaraan,
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColorPalette.textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColorPalette.lavender,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Shift ke-${historyItem.shiftKe}',
                        style: TextStyle(
                          fontSize: 14,
                          color: CustomColorPalette.textColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColorPalette.lavender,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        historyItem.status,
                        style: TextStyle(
                          fontSize: 14,
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
  }
}
