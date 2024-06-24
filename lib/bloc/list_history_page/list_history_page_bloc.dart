import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history_page_event.dart';
import 'package:diantar_jarak/bloc/list_history_page/list_history_page_state.dart';
import 'package:diantar_jarak/data/service/list_history_service/list_history_service.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';

class ListHistoryBloc extends Bloc<ListHistoryEvent, ListHistoryState> {
  final ListHistoryService listHistoryService;

  ListHistoryBloc({required this.listHistoryService})
      : super(ListHistoryInitial()) {
    on<FetchListHistory>(_onFetchListHistory);
  }

  void _onFetchListHistory(
      FetchListHistory event, Emitter<ListHistoryState> emit) async {
    emit(ListHistoryLoading());
    try {
      final ListHistoryModelData listHistory =
          await listHistoryService.getAllHistories();
      log('Fetched list history: ${listHistory.data.length} items');
      emit(ListHistoryLoaded(listHistory));
    } catch (e) {
      log('Fetch error: $e');
      emit(ListHistoryError(e.toString()));
    }
  }
}
