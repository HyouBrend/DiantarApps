import 'package:equatable/equatable.dart';

abstract class EditDeliveryOrderState extends Equatable {
  const EditDeliveryOrderState();

  @override
  List<Object> get props => [];
}

class EditDeliveryOrderInitial extends EditDeliveryOrderState {}

class EditDeliveryOrderLoading extends EditDeliveryOrderState {}

class EditDeliveryOrderSuccess extends EditDeliveryOrderState {
  final String message;

  const EditDeliveryOrderSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class EditDeliveryOrderError extends EditDeliveryOrderState {
  final String message;

  const EditDeliveryOrderError(this.message);

  @override
  List<Object> get props => [message];
}
