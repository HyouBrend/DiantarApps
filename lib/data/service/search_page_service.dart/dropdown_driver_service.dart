import 'package:diantar_jarak/data/models/dropdown_drive_model.dart';
import 'package:diantar_jarak/data/network/api_helper.dart';

class DropdriveService {
  final ApiHelper apiHelper;

  DropdriveService({required this.apiHelper});

  Future<DropdownDriveModelData> getAllDrivers() async {
    try {
      final result = await apiHelper.get(
        url: 'http://127.0.0.1:8010/proxy/list_driver',
      );
      return DropdownDriveModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  Future<DropdownDriveModelData> getDrivers(String query) async {
    try {
      final result = await apiHelper.get(
        url: query.isEmpty ? 'http://127.0.0.1:8010/proxy/list_driver' : 'http://127.0.0.1:8010/proxy/get_driver/$query',
      );
      return DropdownDriveModelData.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }
}
