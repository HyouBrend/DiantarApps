import 'package:diantar_jarak/data/service/history_page_service/update_detail_pengantaran_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'update_detail_pengantaran_event.dart';
import 'update_detail_pengantaran_state.dart';

class UpdateDetailPengantaranBloc
    extends Bloc<UpdateDetailPengantaranEvent, UpdateDetailPengantaranState> {
  final UpdateDetailPengantaranService service;

  UpdateDetailPengantaranBloc(this.service)
      : super(UpdateDetailPengantaranInitial()) {
    on<SubmitUpdateDetailPengantaran>(_onSubmitUpdateDetailPengantaran);
  }

  Future<void> _onSubmitUpdateDetailPengantaran(
      SubmitUpdateDetailPengantaran event,
      Emitter<UpdateDetailPengantaranState> emit) async {
    emit(UpdateDetailPengantaranLoading());

    try {
      await service.submitPengantaran(event.updatePengantaran);
      emit(UpdateDetailPengantaranSuccess());
    } catch (e) {
      emit(UpdateDetailPengantaranFailure(e.toString()));
    }
  }
}
