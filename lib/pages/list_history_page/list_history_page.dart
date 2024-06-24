import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'package:diantar_jarak/data/service/list_history_service/list_history_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page_widget/border_history.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page_widget/search_history.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:diantar_jarak/theme/theme.dart';

class ListHistoryPage extends StatefulWidget {
  @override
  _ListHistoryPageState createState() => _ListHistoryPageState();
}

class _ListHistoryPageState extends State<ListHistoryPage> {
  late ListHistoryService _listHistoryService;
  late Future<ListHistoryModelData> _futureListHistory;
  int _currentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _listHistoryService =
        ListHistoryService(apiHelper: ApiHelperImpl(dio: Dio()));
    _futureListHistory = _listHistoryService.getAllHistories();
  }

  List<ListHistoryModel> _getPaginatedItems(List<ListHistoryModel> items) {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = (_currentPage * _itemsPerPage);
    return items.sublist(
        startIndex, endIndex > items.length ? items.length : endIndex);
  }

  Widget _buildPaginationControls(int totalItems) {
    final totalPages = (totalItems / _itemsPerPage).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return TextButton(
          onPressed: () {
            setState(() {
              _currentPage = index + 1;
            });
          },
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontWeight: _currentPage == index + 1
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List History'),
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: FutureBuilder<ListHistoryModelData>(
        future: _futureListHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final listHistory = snapshot.data!;
            final paginatedItems = _getPaginatedItems(listHistory.data);
            return Column(
              children: [
                SearchHistory(),
                Expanded(
                  child: BorderHistory(historyItems: paginatedItems),
                ),
                _buildPaginationControls(listHistory.data.length),
              ],
            );
          }
          return Center(child: Text('No data available'));
        },
      ),
    );
  }
}
