import 'package:diantar_jarak/data/models/delivery_order_model/produk_model.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class DropProductService {
  final ApiHelper apiHelper;

  DropProductService({required this.apiHelper});

  Future<DropdownProductModelData> getAllProducts() async {
    try {
      final response = await apiHelper.get(
        url: APIJarakLocal.listProducts,
      );
      final result = response.data as Map<String, dynamic>;
      return DropdownProductModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<DropdownProductModelData> getProducts(String query) async {
    try {
      final response = await apiHelper.get(
        url: query.isEmpty
            ? APIJarakLocal.listProducts
            : '${APIJarakLocal.getProduct}/$query',
      );
      final result = response.data as Map<String, dynamic>;
      return DropdownProductModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}
