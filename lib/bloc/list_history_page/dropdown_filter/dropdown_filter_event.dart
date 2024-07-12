import 'package:equatable/equatable.dart';

abstract class DropdownFilterEvent extends Equatable {
  const DropdownFilterEvent();
}

class FetchDropdownFilterData extends DropdownFilterEvent {
  final String query;

  const FetchDropdownFilterData({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class LoadDropdownFilterData extends DropdownFilterEvent {
  @override
  List<Object?> get props => [];
}
