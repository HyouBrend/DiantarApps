import 'package:flutter_bloc/flutter_bloc.dart';
import 'dropdown_filter_event.dart';
import 'dropdown_filter_state.dart';
import 'package:diantar_jarak/data/service/search_page_service/dropdown_driver_service.dart';

class DropdownFilterBloc
    extends Bloc<DropdownFilterEvent, DropdownFilterState> {
  final DropdriveService dropdriveService;

  DropdownFilterBloc({required this.dropdriveService})
      : super(DropdownFilterInitial()) {
    on<FetchDropdownFilterData>((event, emit) async {
      emit(DropdownFilterLoading());
      try {
        final result = await dropdriveService.getDrivers(event.query);
        if (result.data.isNotEmpty) {
          emit(DropdownFilterHasData(result.data));
        } else {
          emit(DropdownFilterEmpty());
        }
      } catch (error) {
        emit(DropdownFilterError(error.toString()));
      }
    });
  }
}
