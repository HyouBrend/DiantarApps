import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';

abstract class ListHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListHistoryInitial extends ListHistoryState {}

class ListHistoryLoading extends ListHistoryState {}

class ListHistoryLoaded extends ListHistoryState {
  final List<HistoryPengantaranModel> histories;
  final int currentPage;

  ListHistoryLoaded({
    required this.histories,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [histories, currentPage];
}

class ListHistoryError extends ListHistoryState {
  final String message;

  ListHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
