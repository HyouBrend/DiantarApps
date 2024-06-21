import 'package:diantar_jarak/bloc/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/data/network/api_helper_dio.dart';
import 'package:diantar_jarak/data/service/search_page_service.dart/dropdown_customer_service.dart';
import 'package:diantar_jarak/data/service/search_page_service.dart/dropdown_driver_service.dart';
import 'package:diantar_jarak/pages/search_page/search_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

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
      ],
      child: const Scaffold(
        body: Row(
          children: [
            Expanded(
              child: SearchPage(),
            ),
          ],
        ),
      ),
    );
  }
}
