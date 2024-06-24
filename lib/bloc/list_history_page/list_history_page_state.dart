import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_list_history_page/model_list_history_page.dart';

abstract class ListHistoryState extends Equatable {
  const ListHistoryState();

  @override
  List<Object> get props => [];
}

class ListHistoryInitial extends ListHistoryState {}

class ListHistoryLoading extends ListHistoryState {}

class ListHistoryLoaded extends ListHistoryState {
  final ListHistoryModelData listHistory;

  const ListHistoryLoaded(this.listHistory);

  @override
  List<Object> get props => [listHistory];
}

class ListHistoryError extends ListHistoryState {
  final String message;

  const ListHistoryError(this.message);

  @override
  List<Object> get props => [message];
}
