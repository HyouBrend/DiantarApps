import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/delivery_order_model/edit_detail_delivery_order_model.dart';

abstract class EditDeliveryOrderEvent extends Equatable {
  const EditDeliveryOrderEvent();

  @override
  List<Object> get props => [];
}

class SubmitEditDeliveryOrder extends EditDeliveryOrderEvent {
  final int deliveryOrderId;
  final EditDeliveryOrderRequest updatedData;

  const SubmitEditDeliveryOrder({
    required this.deliveryOrderId,
    required this.updatedData,
  });

  @override
  List<Object> get props => [deliveryOrderId, updatedData];
}
