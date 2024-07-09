// submit_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/search_page/submit/submit_event.dart';
import 'package:diantar_jarak/bloc/search_page/submit/submit_state.dart';
import 'package:diantar_jarak/data/service/result_page_service.dart/detail_pengantaran_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:dio/dio.dart';

class SubmitBloc extends Bloc<SubmitEvent, SubmitState> {
  final SubmitPengantaranService submitPengantaranService;

  SubmitBloc({required SubmitPengantaranService submitPengantaranService})
      : submitPengantaranService =
            SubmitPengantaranService(apiHelper: ApiHelperImpl(dio: Dio())),
        super(SubmitInitial());

  @override
  Stream<SubmitState> mapEventToState(SubmitEvent event) async* {
    if (event is SubmitPengantaranEvent) {
      yield SubmitLoading();
      try {
        final response = await submitPengantaranService
            .submitPengantaran(event.detailPengantaran);
        yield SubmitSuccess(response);
      } catch (e) {
        yield SubmitFailure(e.toString());
      }
    }
  }
}
