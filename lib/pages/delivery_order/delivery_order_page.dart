import 'package:diantar_jarak/bloc/delivery_order_bloc/product_bloc/produk_bloc.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/get_delivery_order_service.dart';
import 'package:diantar_jarak/pages/delivery_order/delivery_order_widget/get_delivery_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/pages/delivery_order/delivery_order_widget/add_delivery_order_widget.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/produk_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:dio/dio.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/add_delivery_order_service.dart';

class DeliveryOrderPage extends StatefulWidget {
  const DeliveryOrderPage({super.key});

  @override
  DeliveryOrderPageState createState() => DeliveryOrderPageState();
}

// Make the state class public by removing the underscore
class DeliveryOrderPageState extends State<DeliveryOrderPage> {
  final DropProductService dropdownProductService = DropProductService(
    apiHelper: ApiHelperImpl(dio: Dio()),
  );

  final AddDeliveryOrderService addDeliveryOrderService =
      AddDeliveryOrderService(apiHelper: ApiHelperImpl(dio: Dio()));

  final DeliveryOrderService deliveryOrderService =
      DeliveryOrderService(apiHelper: ApiHelperImpl(dio: Dio()));

  double _getHorizontalPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1024) {
      return 200.0;
    } else if (screenWidth >= 600) {
      return 100.0;
    } else {
      return 10.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double padding = _getHorizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery Order',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: CustomColorPalette.textColor,
          ),
        ),
        backgroundColor: CustomColorPalette.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: CustomColorPalette.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              BlocProvider(
                create: (context) => ProductBloc(
                  productService: dropdownProductService,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(color: CustomColorPalette.textColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: AddDeliveryOrderWidget(
                      dropdownProductService: dropdownProductService,
                      deliveryOrderService: addDeliveryOrderService,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Sizes.dp6(context)),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: CustomColorPalette.BgBorder,
                  border: Border.all(color: CustomColorPalette.textColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8.0),
                child: GetOrderDeliveryWidget(
                  deliveryOrderService: deliveryOrderService,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
