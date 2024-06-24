import 'package:diantar_jarak/bloc/serach_page/dropdown_driver_bloc/dropdown_driver_event.dart';
import 'package:diantar_jarak/bloc/serach_page/dropdown_driver_bloc/dropdown_driver_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diantar_jarak/data/service/search_page_service.dart/dropdown_driver_service.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final DropdriveService dropdriveService;

  DriverBloc({required this.dropdriveService}) : super(DriverInitial()) {
    on<FetchDrivers>(_onFetchDrivers);
    // Memanggil FetchDrivers saat inisialisasi
    add(FetchDrivers(''));
  }

  void _onFetchDrivers(FetchDrivers event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
    try {
      print('Fetching drivers for query: ${event.query}');
      final drivers = await dropdriveService.getDrivers(event.query);
      final filteredDrivers = drivers.data
              ?.where((driver) =>
                  driver.nama
                      ?.toLowerCase()
                      .contains(event.query.toLowerCase()) ??
                  false)
              .toList() ??
          [];
      print('Drivers fetched: ${filteredDrivers.length}');
      emit(DriverLoaded(filteredDrivers));
    } catch (e) {
      print('Error fetching drivers: $e'); // Logging error detail
      emit(DriverError('Failed to fetch drivers'));
    }
  }
}
