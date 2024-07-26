import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class DriverFilterChanged extends FilterEvent {
  final String driver;

  const DriverFilterChanged(this.driver);

  @override
  List<Object> get props => [driver];
}

class CheckerFilterChanged extends FilterEvent {
  final String checker;

  const CheckerFilterChanged(this.checker);

  @override
  List<Object> get props => [checker];
}

class StatusFilterChanged extends FilterEvent {
  final String status;

  const StatusFilterChanged(this.status);

  @override
  List<Object> get props => [status];
}

class TimeFilterChanged extends FilterEvent {
  final String time;

  const TimeFilterChanged(this.time);

  @override
  List<Object> get props => [time];
}

class FetchDrivers extends FilterEvent {
  const FetchDrivers();

  @override
  List<Object> get props => [];
}
