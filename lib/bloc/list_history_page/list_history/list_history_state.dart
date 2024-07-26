import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';

abstract class ListHistoryState extends Equatable {
  final bool isLoading;

  ListHistoryState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}

class ListHistoryInitial extends ListHistoryState {}

class ListHistoryLoading extends ListHistoryState {
  ListHistoryLoading() : super(isLoading: true);
}

class ListHistoryLoaded extends ListHistoryState {
  final List<HistoryPengantaranModel> histories;
  final int currentPage;
  final int totalCount;

  ListHistoryLoaded({
    required this.histories,
    required this.currentPage,
    required this.totalCount,
    bool isLoading = false,
  }) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [histories, currentPage, totalCount, isLoading];
}

class ListHistoryError extends ListHistoryState {
  final String message;

  ListHistoryError({required this.message}) : super(isLoading: false);

  @override
  List<Object?> get props => [message, isLoading];
}

class ListHistoryNoData extends ListHistoryState {
  ListHistoryNoData() : super(isLoading: false);
}
