import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/maps/maps_event.dart';
import 'package:diantar_jarak/bloc/maps/maps_state.dart';
import 'package:diantar_jarak/data/service/result_page_service.dart/maps_service.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapsService mapsService;

  MapBloc({required this.mapsService}) : super(MapState()) {
    on<LoadMapData>(_onLoadMapData);
  }

  Future<void> _onLoadMapData(LoadMapData event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(loading: true));
      final drivers = await mapsService.fetchDrivers();
      final customers = await mapsService.fetchCustomers();
      emit(state.copyWith(drivers: drivers, customers: customers, loading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loading: false));
    }
  }
}
