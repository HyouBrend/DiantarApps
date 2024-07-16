part of 'border_history_bloc.dart';

sealed class BorderHistoryState extends Equatable {
  const BorderHistoryState();
  
  @override
  List<Object> get props => [];
}

final class BorderHistoryInitial extends BorderHistoryState {}
