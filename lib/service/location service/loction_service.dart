import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxService {
  final _name = 'LocationService';

  @override
  void onInit() {
    log('Service init', name: _name);
    super.onInit();
  }

  /// Ensures GPS is enabled by triggering the system pop-up first
  Future<bool> ensureGpsEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      try {
        // 🔥 This triggers the system GPS pop-up
        await Geolocator.getCurrentPosition();
        return true; // GPS is enabled
      } catch (e) {
        // ❌ User denied GPS → Show dialog to open settings
        _showGpsDeniedDialog();
        return false;
      }
    }
    return true; // GPS is already enabled
  }

  /// Fetches the current location
  Future<Position?> getCurrentLocation() async {
    bool gpsEnabled = await ensureGpsEnabled();

    if (!gpsEnabled) {
      return null; // User didn't enable GPS
    }

    return await Geolocator.getCurrentPosition();
  }

  /// 🔥 Show a Dialog if the user denies GPS
  void _showGpsDeniedDialog() {
    Get.defaultDialog(
      title: "GPS Required",
      middleText: "Please enable GPS to continue.",
      actions: [
        TextButton(
          onPressed: () => Get.back(), // ❌ Cancel
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(); // Close dialog
            Geolocator.openLocationSettings(); // ⚙️ Open settings
          },
          child: Text("Open Settings"),
        ),
      ],
    );
  }
}
