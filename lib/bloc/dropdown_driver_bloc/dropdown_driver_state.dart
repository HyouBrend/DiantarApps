import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/dropdown_drive_model.dart';

abstract class DriverState extends Equatable {
  const DriverState();

  @override
  List<Object> get props => [];
}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverLoaded extends DriverState {
  final List<DropdownDriveModel> drivers;

  const DriverLoaded(this.drivers);

  @override
  List<Object> get props => [drivers];
}

class DriverError extends DriverState {
  final String message;

  const DriverError(this.message);

  @override
  List<Object> get props => [message];
}