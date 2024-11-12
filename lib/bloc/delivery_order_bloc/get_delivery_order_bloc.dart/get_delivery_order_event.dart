import 'package:diantar_jarak/data/models/delivery_order_model/edit_detail_delivery_order_model.dart';
import 'package:equatable/equatable.dart';

abstract class DeliveryOrderEvent extends Equatable {
  const DeliveryOrderEvent();

  @override
  List<Object?> get props => [];
}

class FetchDeliveryOrders extends DeliveryOrderEvent {
  final int page;
  final int pageSize;

  const FetchDeliveryOrders({this.page = 1, this.pageSize = 10});
}

class DeleteDeliveryOrderEvent extends DeliveryOrderEvent {
  final int id;

  const DeleteDeliveryOrderEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SubmitEditDeliveryOrder extends DeliveryOrderEvent {
  final int deliveryOrderId;
  final EditDeliveryOrderRequest updatedData;

  const SubmitEditDeliveryOrder({
    required this.deliveryOrderId,
    required this.updatedData,
  });

  @override
  List<Object> get props => [deliveryOrderId, updatedData];
}
