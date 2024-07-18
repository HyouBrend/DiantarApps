import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_event.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_state.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page_widget/filter_history.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page_widget/paging_history.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/data/service/list_history_service/history_pengantaran_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:diantar_jarak/pages/list_history_page/list_history_page_widget/card_history.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:dio/dio.dart';

class ListHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListHistoryBloc(
        historyPengantaranService:
            HistoryPengantaranService(apiHelper: ApiHelperImpl(dio: Dio())),
      )..add(FetchHistory(page: 1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'List History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: CustomColorPalette.backgroundColor,
          centerTitle: true,
        ),
        body: BlocBuilder<ListHistoryBloc, ListHistoryState>(
          builder: (context, state) {
            if (state is ListHistoryLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ListHistoryError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ListHistoryLoaded) {
              final listHistory = state.histories;
              final displayedHistory = listHistory
                  .skip((state.currentPage - 1) * 12)
                  .take(12)
                  .toList();
              final totalPages = (listHistory.length / 12).ceil();

              return Column(
                children: [
                  FilterHistory(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: displayedHistory.length,
                        itemBuilder: (context, index) {
                          final item = displayedHistory[index];
                          return CardHistory(historyItem: item);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PagingHistory(
                      currentPage: state.currentPage,
                      totalPages: totalPages,
                      onPageChanged: (page) {
                        BlocProvider.of<ListHistoryBloc>(context)
                            .add(FetchHistory(page: page));
                      },
                    ),
                  ),
                  SizedBox(width: Sizes.dp2(context)),
                ],
              );
            }
            return Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
