import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_bloc.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_event.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/get_delivery_order_bloc.dart/get_delivery_order_state.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/get_delivery_order_service.dart';
import 'package:diantar_jarak/pages/delivery_order/delivery_order_widget/card_delivery_order.dart';
import 'package:diantar_jarak/pages/delivery_order/delivery_order_widget/delivery_order_pagination_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOrderDeliveryWidget extends StatefulWidget {
  final DeliveryOrderService deliveryOrderService;
  final VoidCallback? onRefresh;

  const GetOrderDeliveryWidget({
    super.key,
    required this.deliveryOrderService,
    this.onRefresh,
  });

  @override
  GetOrderDeliveryWidgetState createState() => GetOrderDeliveryWidgetState();
}

class GetOrderDeliveryWidgetState extends State<GetOrderDeliveryWidget> {
  int _currentPage = 1;
  int _pageSize = 10;
  final TextEditingController _pageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchOrders(_currentPage, _pageSize); // Initial data load
  }

  // Public method to refresh orders, accessible from outside
  void refreshOrders() {
    _fetchOrders(_currentPage, _pageSize);
  }

  void _fetchOrders(int page, int pageSize) {
    context.read<DeliveryOrderBloc>().add(
          FetchDeliveryOrders(page: page, pageSize: pageSize),
        );
  }

  @override
  Widget build(BuildContext context) {
    widget.onRefresh
        ?.call(); // Allows external refresh if onRefresh is provided
    return BlocBuilder<DeliveryOrderBloc, DeliveryOrderState>(
      builder: (context, state) {
        if (state is DeliveryOrderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DeliveryOrderError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is DeliveryOrderLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return DeliveryOrderCard(
                      order: order,
                      onOrderUpdated: refreshOrders, // Refresh after an update
                    );
                  },
                ),
              ),
              DeliverOrderPaginationControls(
                currentPage: _currentPage,
                totalPages: state.totalPages,
                rowsPerPage: _pageSize,
                totalItems: state.totalItems,
                pageController: _pageController,
                onPageChanged: (page, pageSize) {
                  setState(() {
                    _currentPage = page;
                    _pageSize = pageSize;
                    _fetchOrders(_currentPage, _pageSize);
                  });
                },
              ),
            ],
          );
        } else {
          return const Center(child: Text('No delivery orders available'));
        }
      },
    );
  }
}
