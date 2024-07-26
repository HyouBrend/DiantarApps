import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_event.dart';
import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_state.dart';
import 'package:diantar_jarak/data/service/history_page_service/detail_pengantaran_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPengantaranBloc
    extends Bloc<DetailPengantaranEvent, DetailPengantaranState> {
  final DetailPengantaranService service;

  DetailPengantaranBloc(this.service) : super(DetailPengantaranInitial()) {
    on<FetchDetailPengantaran>(_onFetchDetailPengantaran);
  }

  void _onFetchDetailPengantaran(FetchDetailPengantaran event,
      Emitter<DetailPengantaranState> emit) async {
    emit(DetailPengantaranLoading());
    try {
      final details = await service.fetchDetailPengantaran(event.perjalananID);
      emit(DetailPengantaranLoaded(details));
    } catch (e) {
      emit(DetailPengantaranError(e.toString()));
    }
  }
}
