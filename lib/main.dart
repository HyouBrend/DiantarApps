import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_bloc.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/product_bloc/produk_bloc.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/get_delivery_order_service.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/produk_service.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

// Bloc imports
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/detail_perjalanan/detail_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_pengantaran/update_detail_pengantaran_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';

// Service imports
import 'package:diantar_jarak/data/service/detail_perjalanan_service/detail_perjalanan_service.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/update_detail_pengantaran_service.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/update_detail_perjalanan_service.dart';
import 'package:diantar_jarak/data/service/history_perjalanan_service/history_perjalanan_service.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/dropdown_customer_service.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/dropdown_driver_service.dart';

// Helper imports
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';

// UI imports
import 'package:diantar_jarak/util/splash_screen.dart';
import 'package:diantar_jarak/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  await Config.loadConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _setupServices(),
      child: MultiBlocProvider(
        providers: _setupBlocs(),
        child: MaterialApp(
          title: 'Diantar Jarak',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(),
          home: const SplashScreen(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', 'ID'), // Bahasa Indonesia
            Locale('en', 'US'), // English
          ],
        ),
      ),
    );
  }

  List<RepositoryProvider> _setupServices() {
    final apiHelper = ApiHelperImpl(dio: Dio());

    return [
      RepositoryProvider<ApiHelper>(
        create: (context) => apiHelper,
      ),
      RepositoryProvider<DetailPerjalananService>(
        create: (context) => DetailPerjalananService(apiHelper: apiHelper),
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
      RepositoryProvider<UpdateDetailPerjalananService>(
        create: (context) =>
            UpdateDetailPerjalananService(apiHelper: apiHelper),
      ),
      RepositoryProvider<DropProductService>(
        create: (context) => DropProductService(apiHelper: apiHelper),
      ),
      RepositoryProvider<DeliveryOrderService>(
        create: (context) => DeliveryOrderService(apiHelper: apiHelper),
      ),
    ];
  }

  List<BlocProvider> _setupBlocs() {
    return [
      BlocProvider<DeliveryOrderBloc>(
        create: (context) => DeliveryOrderBloc(
          deliveryOrderService: context.read<DeliveryOrderService>(),
        ),
      ),
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(
          productService: context.read<DropProductService>(),
        ),
      ),
      BlocProvider<DetailPerjalananBloc>(
        create: (context) => DetailPerjalananBloc(
          context.read<DetailPerjalananService>(),
        ),
      ),
      BlocProvider<DriverBloc>(
        create: (context) => DriverBloc(
          dropdriveService: context.read<DropdriveService>(),
        ),
      ),
      BlocProvider<CustomerBloc>(
        create: (context) => CustomerBloc(
          customerService: context.read<CustomerService>(),
        ),
      ),
      BlocProvider<HistoryPengantaranBloc>(
        create: (context) => HistoryPengantaranBloc(
          historyService: context.read<HistoryPengantaranService>(),
        ),
      ),
      BlocProvider<UpdateDetailPengantaranBloc>(
        create: (context) => UpdateDetailPengantaranBloc(
          context.read<UpdateDetailPengantaranService>(),
        ),
      ),
      BlocProvider<UpdateDetailPerjalananBloc>(
        create: (context) => UpdateDetailPerjalananBloc(
          service: context.read<UpdateDetailPerjalananService>(),
          historyBloc: context.read<HistoryPengantaranBloc>(),
        ),
      ),
    ];
  }

  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      scaffoldBackgroundColor: CustomColorPalette.backgroundColor,
    );
  }
}
