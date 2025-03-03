import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    return _handlePermissionStatus(status, "Camera", Permission.camera);
  }

  static Future<bool> requestGalleryPermission() async {
    var status = await Permission.photos.request();
    return _handlePermissionStatus(status, "Gallery", Permission.photos);
  }

  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    return _handlePermissionStatus(status, "Location", Permission.location);
  }

  static Future<bool> requestAllPermissions() async {
    bool cameraGranted = await requestCameraPermission();
    bool galleryGranted = await requestGalleryPermission();
    bool locationGranted = await requestLocationPermission();

    return cameraGranted && galleryGranted && locationGranted;
  }

  static Future<bool> _handlePermissionStatus(
    PermissionStatus status,
    String permissionName,
    Permission permission,
  ) async {
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      _showPermissionDialog(permissionName, permission);
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog(permissionName);
    }
    return false;
  }

  static void _showPermissionDialog(
    String permissionName,
    Permission permission,
  ) {
    Get.defaultDialog(
      title: "$permissionName Permission Required",
      content: Text(
        "This app requires $permissionName access to function properly.",
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("Don't Allow")),
        ElevatedButton(
          onPressed: () async {
            Get.back();
            await permission.request();
          },
          child: Text("Allow"),
        ),
      ],
    );
  }

  static void _showSettingsDialog(String permissionName) {
    Get.defaultDialog(
      title: "Permission Required",
      content: Text("Please enable $permissionName access in settings."),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
        ElevatedButton(
          onPressed: () => openAppSettings(),
          child: Text("Open Settings"),
        ),
      ],
    );
  }
}
