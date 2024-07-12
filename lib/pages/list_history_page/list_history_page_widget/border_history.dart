import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/pages/history_page/history_page.dart';
import 'package:diantar_jarak/theme/theme.dart';

class BorderHistory extends StatefulWidget {
  final List<HistoryPengantaranModel> historyItems;

  const BorderHistory({Key? key, required this.historyItems}) : super(key: key);

  @override
  _BorderHistoryState createState() => _BorderHistoryState();
}

class _BorderHistoryState extends State<BorderHistory> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.historyItems.length,
      itemBuilder: (context, index) {
        final item = widget.historyItems[index];
        final status = item.status;
        final isHovered = _hoveredIndex == index;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MouseRegion(
            onEnter: (_) {
              setState(() {
                _hoveredIndex = index;
              });
            },
            onExit: (_) {
              setState(() {
                _hoveredIndex = null;
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 5.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: CustomColorPalette.BgBorder,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(historyItem: item),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          item.nama,
                          style: TextStyle(
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                        subtitle: Text(
                          item.waktuPesanan,
                          style: TextStyle(
                            color: CustomColorPalette.textColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: getStatusColor(status),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        getStatusLabel(status),
                        style: TextStyle(
                          color: CustomColorPalette.textColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
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
