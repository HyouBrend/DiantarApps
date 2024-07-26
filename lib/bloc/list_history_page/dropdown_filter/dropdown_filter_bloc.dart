import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_event.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_state.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_driver_service.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final DropdriveService dropdriveService;

  FilterBloc({required this.dropdriveService}) : super(const FilterState()) {
    on<FetchDrivers>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final drivers = await dropdriveService.getAllDrivers();
        final driverNames =
            drivers.data.map((d) => d.nama ?? '').toSet().toList();
        emit(state.copyWith(
          drivers: driverNames,
          isLoading: false,
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          error: e.toString(),
        ));
      }
    });

    on<DriverFilterChanged>((event, emit) {
      emit(state.copyWith(driver: event.driver));
    });

    on<CheckerFilterChanged>((event, emit) {
      emit(state.copyWith(checker: event.checker));
    });

    on<StatusFilterChanged>((event, emit) {
      emit(state.copyWith(status: event.status));
    });

    on<TimeFilterChanged>((event, emit) {
      emit(state.copyWith(time: event.time));
    });
  }
}
