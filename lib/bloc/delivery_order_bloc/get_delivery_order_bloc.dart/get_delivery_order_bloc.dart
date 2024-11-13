import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_event.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_state.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/delete_detail_delivery_order.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/edit_detail_delivery_order_service.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/get_delivery_order_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryOrderBloc extends Bloc<DeliveryOrderEvent, DeliveryOrderState> {
  final DeliveryOrderService deliveryOrderService;
  final DeleteDeliveryOrderService deleteDeliveryOrderService;
  final EditDeliveryOrderService editDeliveryOrderService;

  DeliveryOrderBloc({
    required this.deliveryOrderService,
    required this.deleteDeliveryOrderService,
    required this.editDeliveryOrderService,
  }) : super(DeliveryOrderInitial()) {
    on<FetchDeliveryOrders>(_onFetchDeliveryOrders);
    on<DeleteDeliveryOrderEvent>(_onDeleteDeliveryOrder);
    on<SubmitEditDeliveryOrder>(_onSubmitEditDeliveryOrder);
  }

  Future<void> _onFetchDeliveryOrders(
    FetchDeliveryOrders event,
    Emitter<DeliveryOrderState> emit,
  ) async {
    emit(DeliveryOrderLoading());
    try {
      final response = await deliveryOrderService.getDeliveryOrders(
        page: event.page,
        pageSize: event.pageSize,
      );

      emit(DeliveryOrderLoaded(
        orders: response.data,
        totalPages: response.totalPages,
        totalItems: response.totalItems,
      ));
    } catch (e) {
      emit(DeliveryOrderError(
          "Failed to load delivery orders. Please try again."));
    }
  }

  Future<void> _onDeleteDeliveryOrder(
    DeleteDeliveryOrderEvent event,
    Emitter<DeliveryOrderState> emit,
  ) async {
    try {
      await deleteDeliveryOrderService.deleteDeliveryOrderById(event.id);
      emit(DeliveryOrderDeleted()); // Emit a new state on successful deletion
      add(const FetchDeliveryOrders()); // Refresh data after deletion
    } catch (e) {
      emit(DeliveryOrderError("Failed to delete delivery order."));
    }
  }

  Future<void> _onSubmitEditDeliveryOrder(
    SubmitEditDeliveryOrder event,
    Emitter<DeliveryOrderState> emit,
  ) async {
    try {
      // Ensure the service method also expects EditDeliveryOrderRequest
      await editDeliveryOrderService.editDeliveryOrder(
        event.deliveryOrderId,
        event.updatedData,
      );
      add(const FetchDeliveryOrders()); // Refresh data after edit
    } catch (e) {
      emit(DeliveryOrderError("Failed to edit delivery order."));
    }
  }
}
