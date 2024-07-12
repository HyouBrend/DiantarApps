import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/search_page/submit_pengantaran/submit_pengantaran_event.dart';
import 'package:diantar_jarak/bloc/search_page/submit_pengantaran/submit_pengantaran_state.dart';
import 'package:diantar_jarak/data/service/result_page_service.dart/detail_pengantaran_service.dart';

class SubmitPengantaranBloc
    extends Bloc<SubmitPengantaranEvent, SubmitPengantaranState> {
  final DetailPengantaranRepository repository;

  SubmitPengantaranBloc({required this.repository})
      : super(SubmitPengantaranInitial());

  @override
  Stream<SubmitPengantaranState> mapEventToState(
    SubmitPengantaranEvent event,
  ) async* {
    if (event is SubmitPengantaran) {
      yield PengantaranSubmitting();
      try {
        await repository.submitPengantaran(event.detailPengantaran);
        yield PengantaranSubmitted(detailPengantaran: event.detailPengantaran);
      } catch (e) {
        yield SubmitPengantaranError(message: e.toString());
      }
    }
  }
}
