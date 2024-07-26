import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_bloc.dart';
import 'package:diantar_jarak/bloc/list_history_page/dropdown_filter/dropdown_filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/data/service/list_history_service/history_pengantaran_service.dart';
import 'list_history_event.dart';
import 'list_history_state.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';
import 'dart:async';

class ListHistoryBloc extends Bloc<ListHistoryEvent, ListHistoryState> {
  final HistoryPengantaranService historyPengantaranService;
  final FilterBloc filterBloc;
  late final StreamSubscription filterSubscription;

  ListHistoryBloc({
    required this.historyPengantaranService,
    required this.filterBloc,
  }) : super(ListHistoryInitial()) {
    filterSubscription = filterBloc.stream.listen((state) {
      if (state is FilterState) {
        add(FetchHistory(page: 1));
      }
    });

    on<FetchHistory>(_onFetchHistory);
    on<ChangeHistoryStatusEvent>(_onChangeHistoryStatusEvent);
  }

  void _onFetchHistory(
      FetchHistory event, Emitter<ListHistoryState> emit) async {
    if (state is ListHistoryLoading) return;

    final currentState = state;
    var currentPage = event.page;
    var oldHistories = <HistoryPengantaranModel>[];

    if (currentState is ListHistoryLoaded && currentPage > 1) {
      oldHistories = currentState.histories;
    } else {
      currentPage = 1;
    }

    emit(ListHistoryLoading());

    try {
      final historyData = await historyPengantaranService.getAllHistories();
      var filteredHistories = historyData.data;

      final filterState = filterBloc.state;
      if (filterState is FilterState) {
        if (filterState.driver.isNotEmpty) {
          filteredHistories = filteredHistories
              .where((item) => item.namaDriver == filterState.driver)
              .toList();
        }
        if (filterState.checker.isNotEmpty) {
          filteredHistories = filteredHistories
              .where((item) => item.createdBy == filterState.checker)
              .toList();
        }
        if (filterState.status.isNotEmpty) {
          filteredHistories = filteredHistories
              .where((item) => item.status == filterState.status)
              .toList();
        }
      }

      final totalCount = filteredHistories.length;
      final pagedHistories =
          filteredHistories.skip((currentPage - 1) * 10).take(10).toList();

      print('Total count: $totalCount');
      print('Current page: $currentPage');
      print('Paged histories count: ${pagedHistories.length}');

      if (pagedHistories.isEmpty && currentPage == 1) {
        emit(ListHistoryNoData());
      } else if (pagedHistories.isEmpty) {
        emit(ListHistoryLoaded(
          histories: oldHistories,
          currentPage: currentPage,
          totalCount: totalCount,
        ));
      } else {
        emit(ListHistoryLoaded(
          histories: oldHistories + pagedHistories,
          currentPage: currentPage,
          totalCount: totalCount,
        ));
      }
    } catch (e) {
      emit(ListHistoryError(message: e.toString()));
    }
  }

  void _onChangeHistoryStatusEvent(
      ChangeHistoryStatusEvent event, Emitter<ListHistoryState> emit) {
    if (state is ListHistoryLoaded) {
      final currentState = state as ListHistoryLoaded;
      final updatedHistories = currentState.histories.map((history) {
        if (history.perjalananId == event.perjalananID) {
          return HistoryPengantaranModel(
            createdBy: history.createdBy,
            jamKembali: history.jamKembali,
            jamPengiriman: history.jamPengiriman,
            minDurasiPengiriman: history.minDurasiPengiriman,
            minJarakPengiriman: history.minJarakPengiriman,
            namaDriver: history.namaDriver,
            nomorPolisiKendaraan: history.nomorPolisiKendaraan,
            perjalananId: history.perjalananId,
            shiftKe: history.shiftKe,
            status: event.newStatus,
            tipeKendaraan: history.tipeKendaraan,
          );
        }
        return history;
      }).toList();
      emit(ListHistoryLoaded(
        histories: updatedHistories,
        currentPage: currentState.currentPage,
        totalCount: currentState.totalCount,
      ));
    }
  }

  @override
  Future<void> close() {
    filterSubscription.cancel();
    return super.close();
  }
}
