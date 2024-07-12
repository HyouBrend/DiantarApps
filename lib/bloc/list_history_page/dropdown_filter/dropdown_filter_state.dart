import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';

abstract class DropdownFilterState extends Equatable {
  const DropdownFilterState();

  @override
  List<Object> get props => [];
}

class DropdownFilterInitial extends DropdownFilterState {}

class DropdownFilterLoading extends DropdownFilterState {}

class DropdownFilterError extends DropdownFilterState {
  final String message;

  const DropdownFilterError(this.message);

  @override
  List<Object> get props => [message];
}

class DropdownFilterHasData extends DropdownFilterState {
  final List<DropdownDriveModel> drivers;

  const DropdownFilterHasData(this.drivers);

  @override
  List<Object> get props => [drivers];
}

class DropdownFilterEmpty extends DropdownFilterState {}
