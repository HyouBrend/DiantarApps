import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_event.dart';
import 'package:diantar_jarak/bloc/history_page/detail_pengantaran/detail_pengantaran_state.dart';
import 'package:diantar_jarak/data/service/history_page_service/detail_pengantaran_service.dart';

class DetailPengantaranBloc
    extends Bloc<DetailPengantaranEvent, DetailPengantaranState> {
  final DetailPengantaranService service;

  DetailPengantaranBloc({required this.service})
      : super(DetailPengantaranInitial());

  @override
  Stream<DetailPengantaranState> mapEventToState(
      DetailPengantaranEvent event) async* {
    if (event is FetchDetailPengantaran) {
      yield DetailPengantaranLoading();
      try {
        final detailPengantaran =
            await service.fetchDetailPengantaran(event.perjalananID);
        yield DetailPengantaranLoaded(detailPengantaran: detailPengantaran);
      } catch (e) {
        yield DetailPengantaranError(message: e.toString());
      }
    }
  }
}
