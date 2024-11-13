import 'package:diantar_jarak/data/models/delivery_order_model/get_delivery_order_model.dart';
import 'package:equatable/equatable.dart';

abstract class DeliveryOrderState extends Equatable {
  const DeliveryOrderState();

  @override
  List<Object> get props => [];
}

class DeliveryOrderInitial extends DeliveryOrderState {}

class DeliveryOrderLoading extends DeliveryOrderState {}

class DeliveryOrderLoaded extends DeliveryOrderState {
  final List<DeliveryOrder> orders;
  final int totalPages;
  final int totalItems;

  const DeliveryOrderLoaded({
    required this.orders,
    required this.totalPages,
    required this.totalItems,
  });

  @override
  List<Object> get props => [orders, totalPages, totalItems];
}

class DeliveryOrderError extends DeliveryOrderState {
  final String message;

  const DeliveryOrderError(this.message);

  @override
  List<Object> get props => [message];
}

class DeliveryOrderDeleted extends DeliveryOrderState {}
