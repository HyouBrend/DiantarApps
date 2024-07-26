import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_event.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_state.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_driver_service.dart';
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
    final apiHelper = ApiHelperImpl(dio: Dio());
    final dropdriveService = DropdriveService(apiHelper: apiHelper);
    final filterBloc = FilterBloc(dropdriveService: dropdriveService);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListHistoryBloc(
            historyPengantaranService:
                HistoryPengantaranService(apiHelper: apiHelper),
            filterBloc: filterBloc,
          )..add(FetchHistory(page: 1)),
        ),
        BlocProvider.value(
          value: filterBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'List History',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363535),
            ),
          ),
          backgroundColor: CustomColorPalette.backgroundColor,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilterHistory(),
            Expanded(
              child: BlocBuilder<ListHistoryBloc, ListHistoryState>(
                builder: (context, state) {
                  if (state is ListHistoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ListHistoryError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is ListHistoryNoData) {
                    return const Center(child: Text('Tidak ada data'));
                  } else if (state is ListHistoryLoaded) {
                    final listHistory = state.histories;
                    final displayedHistory = listHistory
                        .skip((state.currentPage - 1) * 10)
                        .take(10)
                        .toList();
                    final totalPages = (state.totalCount / 10).ceil();

                    return Column(
                      children: [
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
                  return const Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
