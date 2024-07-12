import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_bloc.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/search_page/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_customer_service.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_driver_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:diantar_jarak/pages/page_screen.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiHelper = ApiHelperImpl(dio: Dio());
    final dropdriveService = DropdriveService(apiHelper: apiHelper);
    final customerService = CustomerService(apiHelper: apiHelper);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DriverBloc(dropdriveService: dropdriveService),
        ),
        BlocProvider(
          create: (context) => CustomerBloc(customerService: customerService),
        ),
        BlocProvider(
          create: (context) => DropdownFilterBloc(
            dropdriveService: dropdriveService,
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
    );
  }
}
