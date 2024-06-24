import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';

class HistoryPage extends StatelessWidget {
  final ListHistoryModel historyItem;

  const HistoryPage({Key? key, required this.historyItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Detail'),
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${historyItem.nama}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Order Time: ${historyItem.waktuPesanan}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
