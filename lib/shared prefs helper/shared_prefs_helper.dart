import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/geo_tagged_items/geo_tagged_item.dart' show GeoTaggedItem;

class SharedPref {
  static final _instance = SharedPref._internal();
  SharedPreferences? _prefs;

  SharedPref._internal();
  factory SharedPref() => _instance;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save List of GeoTaggedItem as JSON String
  Future<bool> saveGeoTaggedItems(List<GeoTaggedItem> items) async {
    String jsonString = jsonEncode(items.map((item) => item.toJson()).toList());
    return await _prefs?.setString("geoTaggedItems", jsonString) ?? false;
  }

  /// Retrieve List of GeoTaggedItem from JSON String
  List<GeoTaggedItem> getGeoTaggedItems() {
    String? jsonString = _prefs?.getString("geoTaggedItems");
    if (jsonString == null) return [];

    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => GeoTaggedItem.fromJson(json)).toList();
  }
}
