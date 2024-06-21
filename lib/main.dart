import 'package:diantar_jarak/pages/page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/maps/maps_bloc.dart';
import 'package:diantar_jarak/data/service/result_page_service.dart/maps_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapBloc(mapsService: MapsService()),
        ),
      ],
      child: MaterialApp(
        title: 'Diantar Jarak',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PageScreen(),
      ),
    );
  }
}
