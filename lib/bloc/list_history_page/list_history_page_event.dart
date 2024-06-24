import 'package:equatable/equatable.dart';

abstract class ListHistoryEvent extends Equatable {
  const ListHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchListHistory extends ListHistoryEvent {}
