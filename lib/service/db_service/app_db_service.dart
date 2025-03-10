import 'package:get/get.dart';

import '../../database/service/db_service.dart';

class AppDbService extends GetxService {
  late AppDatabase mDbInstance;
  @override
  void onInit() async {
    super.onInit();

    mDbInstance = AppDatabase();

    await addRecord();
    await getRecord();
  }

  Future<void> addRecord() async {
    await mDbInstance.into(mDbInstance.geoData).insert(GeoDataCompanion.insert(title: "Ankit Rajak", desc: "Software Developer"));
  }

  Future<void> getRecord() async {
    var allItems = await mDbInstance.select(mDbInstance.geoData).get();
    print(allItems);
  }
}
