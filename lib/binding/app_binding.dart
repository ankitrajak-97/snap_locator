import 'package:get/get.dart';
import 'package:snap_locator/service/data_provider/data_provider_service.dart';
import 'package:snap_locator/service/db_service/app_db_service.dart';
import 'package:snap_locator/service/location_service/loction_service.dart';
import 'package:snap_locator/service/permission_service/permission_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PermissionService());
    Get.put(AppDbService());
    Get.put(LocationService());
    Get.put(DataProviderService());
  }
}
