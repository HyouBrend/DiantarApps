import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomers extends CustomerEvent {
  final String query;

  const FetchCustomers(this.query);

  @override
  List<Object> get props => [query];
}
