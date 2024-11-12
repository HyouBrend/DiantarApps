import 'package:equatable/equatable.dart';

abstract class DeliveryOrderEvent extends Equatable {
  const DeliveryOrderEvent();

  @override
  List<Object> get props => [];
}

class FetchDeliveryOrders extends DeliveryOrderEvent {
  final int page;
  final int pageSize;

  const FetchDeliveryOrders({this.page = 1, this.pageSize = 10});
}
