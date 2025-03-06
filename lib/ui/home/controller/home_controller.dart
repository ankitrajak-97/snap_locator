import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snap_locator/service/location%20service/loction_service.dart';
import 'package:snap_locator/ui/home/view/geo_tagged_input.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/geo_item.dart';
import '../../../service/permission service/permission_service.dart';
import '../../../utils/style/app_dimen.dart';
import '../widget/image_source_bottomsheet.dart';

class HomeController extends GetxController {
  final _name = "HomeController";
  final locationProvider = Get.find<LocationService>();
  var geoTaggedItems = <GeoTaggedItem>[].obs;

  // *Form Fields
  // ? controllers
  var nameController = TextEditingController();
  var descController = TextEditingController();
  Rxn<File> selectedImage = Rxn<File>();

  void saveGeoTaggedItem() async {
    if (nameController.text.isNotEmpty && descController.text.isNotEmpty) {
      try {
        // Get the current location
        Position position = await locationProvider.getCurrentLocation();

        // Print latitude and longitude to console
        print(
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}",
        );

        geoTaggedItems.add(
          GeoTaggedItem(
            name: nameController.text,
            description: descController.text,
            imagePath: selectedImage.value?.path,
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        );

        nameController.clear();
        descController.clear();
        selectedImage.value = null;

        Get.back();
      } catch (e) {
        print("Location Error: $e"); // Print error in case of failure
        Get.snackbar(
          "Location Error",
          "Could not fetch location. Please enable GPS and try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Please enter both Name and Description",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Function to show image picker options (Gallery/Camera)
  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => ImageSourceBottomSheet(
            onImageSourceSelected: (ImageSource source) {
              pickImage(source);
            },
          ),
    );
  }

  // Function to pick an image (Gallery/Camera)
  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  //? Future<void> getCurrentLocation() async {
  //?   bool serviceEnabled;
  //?   LocationPermission permission;
  //?
  //?   // Check if location services are enabled
  //?   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //?   if (!serviceEnabled) {
  //?     Get.snackbar("Error", "Location services are disabled");
  //?     return;
  //?   }
  //?
  //?   // Check for permissions
  //?   permission = await Geolocator.checkPermission();
  //?   if (permission == LocationPermission.denied) {
  //?     permission = await Geolocator.requestPermission();
  //?     if (permission == LocationPermission.denied) {
  //?       Get.snackbar("Error", "Location permissions are denied");
  //?       return;
  //?     }
  //?   }
  //?
  //?   if (permission == LocationPermission.deniedForever) {
  //?     Get.snackbar("Error", "Location permissions are permanently denied.");
  //?     return;
  //?   }
  //?
  //?   // Get current position
  //?   Position position = await Geolocator.getCurrentPosition(
  //?     // desiredAccuracy: LocationAccuracy.high,
  //?   );
  //?
  //?   print("Current Location: ${position.latitude}, ${position.longitude}");
  //? }

  void openGoogleMaps(double? lat, double? lng) {
    if (lat == null || lng == null) {
      Get.snackbar("Error", "Location data is missing!");
      return;
    }
    final url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(kRadius * 3)),
      ),
      builder: (context) => const GeoTaggedInput(),
    );
  }

  Future<void> permissionCheck() async {
    var mapPermissions = await PermissionService.requestMultiplePermissions();

    PermissionService.whenPermissionNotGranted(deniedList: mapPermissions);
    print(mapPermissions);
  }

  @override
  void onReady() {
    super.onReady();
    permissionCheck();
  }

  void onClickFabIcon() async {
    bool allPermissionsGranted =
        await PermissionService.requestAllPermissions();

    if (allPermissionsGranted) {
      print('opening bottomsheet');
      openBottomSheet(Get.context!);
    } else {
      Get.snackbar(
        "Permissions Required",
        "Please grant all permissions (Camera, Gallery, Location) to continue.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
