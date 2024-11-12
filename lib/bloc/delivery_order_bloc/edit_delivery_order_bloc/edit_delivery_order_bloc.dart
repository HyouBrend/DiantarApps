import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/edit_detail_delivery_order_service.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/edit_delivery_order_bloc/edit_delivery_order_event.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/edit_delivery_order_bloc/edit_delivery_order_state.dart';

class EditDeliveryOrderBloc
    extends Bloc<EditDeliveryOrderEvent, EditDeliveryOrderState> {
  final EditDeliveryOrderService editDeliveryOrderService;

  EditDeliveryOrderBloc({required this.editDeliveryOrderService})
      : super(EditDeliveryOrderInitial()) {
    on<SubmitEditDeliveryOrder>(_onSubmitEditDeliveryOrder);
  }

  Future<void> _onSubmitEditDeliveryOrder(
    SubmitEditDeliveryOrder event,
    Emitter<EditDeliveryOrderState> emit,
  ) async {
    emit(EditDeliveryOrderLoading());

    try {
      final message = await editDeliveryOrderService.editDeliveryOrder(
        event.deliveryOrderId,
        event.updatedData,
      );
      emit(EditDeliveryOrderSuccess(message));
    } catch (e) {
      emit(EditDeliveryOrderError('Failed to update: $e'));
    }
  }
}
