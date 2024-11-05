import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildApp(_setupServices());
  }

  MultiRepositoryProvider _buildApp(List<RepositoryProvider> services) {
    return MultiRepositoryProvider(
      providers: services,
      child: MultiBlocProvider(
        providers: _setupBlocs(),
        child: MaterialApp(
          title: 'Diantar Jarak',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(),
          home: SplashScreen(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', 'ID'), // Bahasa Indonesia
            Locale('en', 'US'), // Bahasa Inggris
          ],
        ),
      ),
    );
  }

  List<RepositoryProvider> _setupServices() {
    final apiHelper = ApiHelperImpl(
      dio: Dio()
        ..options = BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
    );

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
    ];
  }

  List<BlocProvider> _setupBlocs() {
    return [
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
