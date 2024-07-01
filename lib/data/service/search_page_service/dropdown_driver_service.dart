import 'package:diantar_jarak/helpers/api/api_strings.dart';
import 'package:diantar_jarak/data/models/model_page_search/dropdown_drive_model.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';

class DropdriveService {
  final ApiHelper apiHelper;

  DropdriveService({required this.apiHelper});

  Future<DropdownDriveModelData> getAllDrivers() async {
    try {
      final result = await apiHelper.get(
        url: APIJarakLocal.listDrivers,
      );
      return DropdownDriveModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<DropdownDriveModelData> getDrivers(String query) async {
    try {
      final result = await apiHelper.get(
        url: query.isEmpty
            ? APIJarakLocal.listDrivers
            : '${APIJarakLocal.getDriver}/$query',
      );
      return DropdownDriveModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}
