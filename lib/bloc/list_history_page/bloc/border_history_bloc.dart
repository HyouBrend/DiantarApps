import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'border_history_event.dart';
part 'border_history_state.dart';

class BorderHistoryBloc extends Bloc<BorderHistoryEvent, BorderHistoryState> {
  BorderHistoryBloc() : super(BorderHistoryInitial()) {
    on<BorderHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
