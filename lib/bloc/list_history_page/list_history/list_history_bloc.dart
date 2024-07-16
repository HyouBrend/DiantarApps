import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/data/service/list_history_service/list_history_service.dart';
import 'list_history_event.dart';
import 'list_history_state.dart';

class ListHistoryBloc extends Bloc<ListHistoryEvent, ListHistoryState> {
  final HistoryPengantaranService historyPengantaranService;

  ListHistoryBloc({required this.historyPengantaranService})
      : super(ListHistoryInitial());

  @override
  Stream<ListHistoryState> mapEventToState(ListHistoryEvent event) async* {
    if (event is FetchHistory) {
      if (state is ListHistoryLoading) return;

      final currentState = state;
      var currentPage = 1;
      var oldHistories = <HistoryPengantaranModel>[];

      if (currentState is ListHistoryLoaded) {
        currentPage = event.page;
        oldHistories = currentState.histories;
      }

      yield ListHistoryLoading();

      try {
        final historyData = await historyPengantaranService.getAllHistories();
        yield ListHistoryLoaded(
          histories: oldHistories + historyData.data,
          currentPage: currentPage,
        );
      } catch (e) {
        yield ListHistoryError(message: e.toString());
      }
    }
  }
}
