import 'package:diantar_jarak/bloc/delivery_order_bloc/product_bloc/produk_event.dart';
import 'package:diantar_jarak/bloc/delivery_order_bloc/product_bloc/produk_state.dart';
import 'package:diantar_jarak/data/service/delivery_order_service/produk_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final DropProductService productService;

  ProductBloc({required this.productService}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());

      final result = await productService.getProducts(event.query);

      if (result.data.isEmpty) {
        emit(const ProductHasData([]));
      } else {
        emit(ProductHasData(result.data));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
