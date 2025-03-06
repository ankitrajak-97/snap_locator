import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService {
  static final _name = "PermissionHelper";
  // ask the user
  static Future<Map<Permission, PermissionStatus>>
  requestMultiplePermissions() async {
    return await [
      Permission.location,
      Permission.camera,
      Permission.photos,
    ].request();
  }

  @override
  void onInit() {
    log("Service Init", name: _name);
    super.onInit();
  }

  @override
  void onReady() {
    log("Service Ready", name: _name);
    super.onReady();
  }
  // ask again -> call the above function again

  // show dialog and move to settings
  static void routeToSettingsPage(
    Map<Permission, PermissionStatus> deniedList,
  ) {
    // get list of all permanently denied permissions
    var permanentlyDeniedList = deniedList.entries.where((mapObject) {
      return mapObject.value == PermissionStatus.permanentlyDenied;
    });

    // create a list of extracted names
    var permissionStringList = [];
    for (var item in permanentlyDeniedList) {
      log(item.key.toString(), name: _name);
      // Permission.camera => camera (split by ".".last)
      permissionStringList.add(item.key.toString().split(".").last);
    }

    // create variable
    var descText = permissionStringList.join(",");

    // show dialog
  }

  // show dialog and move to settings
  static void dialogForDeniedPermission(
    Map<Permission, PermissionStatus> deniedList,
  ) {
    // get list of all permanently denied permissions
    var mDeniedList = deniedList.entries.where((mapObject) {
      return mapObject.value == PermissionStatus.denied;
    });

    // create a list of extracted names
    var permissionStringList = [];
    for (var item in mDeniedList) {
      log(item.key.toString(), name: _name);
      // Permission.camera => camera (split by ".".last)
      permissionStringList.add(item.key.toString().split(".").last);
    }

    // craate variable
    var descText = permissionStringList.join(",");

    // show dialog
  }

  // show dialog and move to settings
  static void whenPermissionNotGranted({
    required Map<Permission, PermissionStatus> deniedList,
  }) async {
    // handle denied cased
    var mDeniedList =
        deniedList.entries
            .where((mapObject) => mapObject.value == PermissionStatus.denied)
            .toList();
    if (mDeniedList.isNotEmpty) {
      var pendingPermissionList = mDeniedList.map((item) => item.key).toList();
      if (pendingPermissionList.isNotEmpty)
        await pendingPermissionList.request();
      return;
    }

    // handle permanently denied cases
    var mPermanentlyDenied =
        deniedList.entries
            .where(
              (mapObject) =>
                  mapObject.value == PermissionStatus.permanentlyDenied,
            )
            .toList();

    if (mPermanentlyDenied.isNotEmpty) {
      // pending permissions
      var pendingPermissionList =
          mPermanentlyDenied.map((item) => item.key).toList();
      if (pendingPermissionList.isNotEmpty) {
        // list of string
        var listStringPermission = pendingPermissionList
            .map((item) => item.toString().split(".").last)
            .toList()
            .join(",");
        log(listStringPermission, name: _name);
      }
      return;
    }

    log("ALL PERMISISON ARE GRANTED", name: _name);
  }

  static Future<bool> _requestCameraPermission() async {
    var status = await Permission.camera.request();
    return _handlePermissionStatus(status, "Camera", Permission.camera);
  }

  static Future<bool> _requestGalleryPermission() async {
    var status = await Permission.photos.request();
    return _handlePermissionStatus(status, "Gallery", Permission.photos);
  }

  static Future<bool> _requestLocationPermission() async {
    var status = await Permission.location.request();
    return _handlePermissionStatus(status, "Location", Permission.location);
  }

  static Future<bool> requestAllPermissions() async {
    bool cameraGranted = await _requestCameraPermission();
    bool galleryGranted = await _requestGalleryPermission();
    bool locationGranted = await _requestLocationPermission();

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
