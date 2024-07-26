import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final String driver;
  final String checker;
  final String status;
  final String time; // Add time property
  final List<String> drivers;
  final bool isLoading;
  final String? error;

  const FilterState({
    this.driver = '',
    this.checker = '',
    this.status = '',
    this.time = '', // Initialize time
    this.drivers = const [],
    this.isLoading = false,
    this.error,
  });

  FilterState copyWith({
    String? driver,
    String? checker,
    String? status,
    String? time, // Add time to copyWith
    List<String>? drivers,
    bool? isLoading,
    String? error,
  }) {
    return FilterState(
      driver: driver ?? this.driver,
      checker: checker ?? this.checker,
      status: status ?? this.status,
      time: time ?? this.time, // Add time to copyWith
      drivers: drivers ?? this.drivers,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object> get props => [driver, checker, status, time, drivers, isLoading];

  @override
  bool get stringify => true;
}
