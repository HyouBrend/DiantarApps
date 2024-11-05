import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_state.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/update_detail_perjalanan_service.dart';

class UpdateDetailPerjalananBloc
    extends Bloc<UpdateDetailPerjalananEvent, UpdateDetailPerjalananState> {
  final UpdateDetailPerjalananService service;
  final HistoryPengantaranBloc historyBloc;

  UpdateDetailPerjalananBloc({
    required this.service,
    required this.historyBloc,
  }) : super(UpdateDetailPerjalananInitial()) {
    on<SubmitUpdateDetailPerjalanan>(_onSubmitUpdateDetailPerjalanan);
  }

  Future<void> _onSubmitUpdateDetailPerjalanan(
    SubmitUpdateDetailPerjalanan event,
    Emitter<UpdateDetailPerjalananState> emit,
  ) async {
    emit(UpdateDetailPerjalananLoading());

    try {
      // Panggil service untuk update detail perjalanan
      await service.updateDetailPerjalanan(event.detail);

      // Emit state sukses setelah berhasil update
      emit(UpdateDetailPerjalananSuccess());

      // Emit event ke history untuk memperbarui data
      historyBloc.add(FetchHistoryPengantaran(
        page: 1,
        pageSize: 10,
        filters: {},
      ));
    } catch (e) {
      emit(UpdateDetailPerjalananError('Error: ${e.toString()}'));
    }
  }
}
