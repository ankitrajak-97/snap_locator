import 'package:get/get.dart';
import 'package:snap_locator/service/data%20provider/data_provider_service.dart';
import 'package:snap_locator/service/location%20service/loction_service.dart';
import 'package:snap_locator/service/permission%20service/permission_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PermissionService());
    Get.put(LocationService());
    Get.put(DataProviderService());
  }
}
