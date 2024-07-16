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
