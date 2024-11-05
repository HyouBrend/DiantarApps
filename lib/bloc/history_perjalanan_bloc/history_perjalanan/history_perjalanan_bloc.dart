import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';
import 'package:diantar_jarak/data/service/history_perjalanan_service/history_perjalanan_service.dart';

class HistoryPengantaranBloc
    extends Bloc<HistoryPengantaranEvent, HistoryPengantaranState> {
  final HistoryPengantaranService historyService;
  static const int defaultPageSize = 10;

  HistoryPengantaranBloc({required this.historyService})
      : super(HistoryLoading()) {
    on<FetchHistoryPengantaran>(_onFetchHistory);
    on<UpdateFilters>(_onUpdateFilters);
  }

  /// Event handler untuk mengambil data history berdasarkan pagination.
  Future<void> _onFetchHistory(
    FetchHistoryPengantaran event,
    Emitter<HistoryPengantaranState> emit,
  ) async {
    emit(HistoryLoading());

    try {
      final result = await historyService.getHistoryPengantaran(
        page: event.page,
        pageSize: event.pageSize,
        filters: event.filters,
      );

      // Cetak total jarak untuk debugging
      print('Total Jarak: ${result.totalJarakKeseluruhan}');

      emit(HistoryLoaded(
        histories: result.data,
        hasReachedMax:
            result.pagination.currentPage >= result.pagination.totalPages,
        currentPage: result.pagination.currentPage,
        currentFilters: event.filters,
        totalJarak: result.totalJarakKeseluruhan,
        totalPages: result.pagination.totalPages,
        totalItems: result.pagination.totalItems,
      ));
    } catch (e) {
      emit(HistoryError('Error fetching history: ${e.toString()}'));
    }
  }

  /// Event handler untuk memperbarui filter dan mengambil data ulang.
  Future<void> _onUpdateFilters(
    UpdateFilters event,
    Emitter<HistoryPengantaranState> emit,
  ) async {
    emit(HistoryLoading());

    try {
      final result = await historyService.getHistoryPengantaran(
        page: 1,
        pageSize: defaultPageSize,
        filters: event.filters,
      );

      emit(HistoryLoaded(
        histories: result.data,
        hasReachedMax:
            result.pagination.currentPage >= result.pagination.totalPages,
        currentPage: 1,
        currentFilters: event.filters,
        totalJarak: result.totalJarakKeseluruhan,
        totalPages: result.pagination.totalPages,
        totalItems: result.pagination.totalItems,
      ));
    } catch (e) {
      emit(HistoryError('Error updating filters: ${e.toString()}'));
    }
  }
}
