import 'package:get/get.dart';

import '../../model/geo_tagged_items/geo_tagged_item.dart';
import '../../shared_prefs_helper/shared_prefs_helper.dart';

class DataProviderService extends GetxService {
  final _name = "DataService";
  final SharedPref _pref = SharedPref();

  List<GeoTaggedItem> geoTaggedItems = [];

  @override
  Future<void> onReady() async {
    super.onReady();
    await _pref.init();
    loadGeoTaggedItems();
  }

  /// Save geo-tagged items to SharedPreferences
  Future<void> saveGeoTaggedItems(List<GeoTaggedItem> items) async {
    geoTaggedItems = items; // Update local list
    await _pref.saveGeoTaggedItems(items);
  }

  /// Load geo-tagged items from SharedPreferences
  void loadGeoTaggedItems() {
    geoTaggedItems = _pref.getGeoTaggedItems();
  }
}
