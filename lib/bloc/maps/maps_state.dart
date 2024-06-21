import 'package:diantar_jarak/data/models/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/models/dropdown_drive_model.dart';
import 'package:equatable/equatable.dart';


class MapState extends Equatable {
  final List<DropdownDriveModel> drivers;
  final List<DropdownCustomerModel> customers;
  final bool loading;
  final String error;

  MapState({
    this.drivers = const [],
    this.customers = const [],
    this.loading = false,
    this.error = '',
  });

  MapState copyWith({
    List<DropdownDriveModel>? drivers,
    List<DropdownCustomerModel>? customers,
    bool? loading,
    String? error,
  }) {
    return MapState(
      drivers: drivers ?? this.drivers,
      customers: customers ?? this.customers,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [drivers, customers, loading, error];
}