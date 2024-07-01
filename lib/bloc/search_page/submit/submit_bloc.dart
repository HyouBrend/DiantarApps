import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/search_page/submit/submit_event.dart';
import 'package:diantar_jarak/bloc/search_page/submit/submit_state.dart';

class SubmitBloc extends Bloc<SubmitEvent, SubmitState> {
  SubmitBloc() : super(SubmitInitial()) {
    on<SubmitButtonPressed>((event, emit) async {
      emit(SubmitInProgress());
      // Simulasi proses submit data
      await Future.delayed(Duration(seconds: 2));
      emit(SubmitSuccess());
    });
  }
}
