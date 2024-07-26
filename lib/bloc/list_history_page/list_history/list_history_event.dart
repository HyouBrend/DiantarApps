import 'package:equatable/equatable.dart';

abstract class ListHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchHistory extends ListHistoryEvent {
  final int page;

  FetchHistory({required this.page});

  @override
  List<Object> get props => [page];
}

class ChangeHistoryStatusEvent extends ListHistoryEvent {
  final String perjalananID;
  final String newStatus;

  ChangeHistoryStatusEvent(this.perjalananID, this.newStatus);

  @override
  List<Object> get props => [perjalananID, newStatus];
}

class UpdateHistoryEvent extends ListHistoryEvent {
  final String perjalananID;

  UpdateHistoryEvent(this.perjalananID);

  @override
  List<Object> get props => [perjalananID];
}
