import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_event.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_state.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/get_delivery_order_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeliveryOrderBloc extends Bloc<DeliveryOrderEvent, DeliveryOrderState> {
  final DeliveryOrderService deliveryOrderService;

  DeliveryOrderBloc({required this.deliveryOrderService})
      : super(DeliveryOrderInitial()) {
    on<FetchDeliveryOrders>(_onFetchDeliveryOrders);
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
      print("Bloc encountered an error: $e"); // Log the error
      emit(DeliveryOrderError(
          "Failed to load delivery orders. Please try again."));
    }
  }
}
