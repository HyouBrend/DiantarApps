import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_bloc.dart';
import 'package:diantar_jarak/bloc/history_page/update_detail_pengantaran/update_detail_pengantaran_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_bloc.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/data/service/history_page_service/detail_pengantaran_service.dart';
import 'package:diantar_jarak/data/service/history_page_service/update_detail_pengantaran_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/pages/page_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history/list_history_bloc.dart';
import 'package:diantar_jarak/data/service/list_history_service/history_pengantaran_service.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_customer_service.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_driver_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiHelper = ApiHelperImpl(dio: Dio());

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiHelper>(
          create: (context) => apiHelper,
        ),
        RepositoryProvider<DetailPengantaranService>(
          create: (context) => DetailPengantaranService(apiHelper: apiHelper),
        ),
        RepositoryProvider<DropdriveService>(
          create: (context) => DropdriveService(apiHelper: apiHelper),
        ),
        RepositoryProvider<CustomerService>(
          create: (context) => CustomerService(apiHelper: apiHelper),
        ),
        RepositoryProvider<HistoryPengantaranService>(
          create: (context) => HistoryPengantaranService(apiHelper: apiHelper),
        ),
        RepositoryProvider<UpdateDetailPengantaranService>(
          create: (context) =>
              UpdateDetailPengantaranService(apiHelper: apiHelper),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DetailPengantaranBloc(
              context.read<DetailPengantaranService>(),
            ),
          ),
          BlocProvider(
            create: (context) => DriverBloc(
              dropdriveService: context.read<DropdriveService>(),
            ),
          ),
          BlocProvider(
            create: (context) => CustomerBloc(
              customerService: context.read<CustomerService>(),
            ),
          ),
          BlocProvider(
            create: (context) => FilterBloc(
              dropdriveService: context.read<DropdriveService>(),
            ),
          ),
          BlocProvider(
            create: (context) => ListHistoryBloc(
              historyPengantaranService:
                  context.read<HistoryPengantaranService>(),
              filterBloc: context.read<FilterBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => UpdateDetailPengantaranBloc(
              context.read<UpdateDetailPengantaranService>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Diantar Jarak',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: CustomColorPalette.backgroundColor,
          ),
          home: const PageScreen(),
        ),
      ),
    );
  }
}
