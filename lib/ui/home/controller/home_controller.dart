import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snap_locator/service/location_service/loction_service.dart';
import 'package:snap_locator/ui/home/view/geo_tagged_input.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/base/base_response.dart';
import '../../../model/geo_tagged_items/geo_tagged_item.dart';
import '../../../service/data_provider/data_provider_service.dart';
import '../../../service/permission_service/permission_service.dart';
import '../../../utils/style/app_dimen.dart';
import '../widget/image_source_bottomsheet.dart';

class HomeController extends GetxController {
  final _name = "HomeController";
  final locationProvider = Get.find<LocationService>();
  final permissionProvider = Get.find<PermissionService>();
  final dataProvider = Get.find<DataProviderService>();
  var geoTaggedItems = <GeoTaggedItem>[].obs;

  // *Form Fields
  // ? controllers
  var nameController = TextEditingController();
  var descController = TextEditingController();
  Rxn<File> selectedImage = Rxn<File>();
  var isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    geoTaggedItems.addAll(dataProvider.geoTaggedItems);
  }

  Future<void> saveGeoTaggedItem() async {
    if (isSaving.value) return;
    isSaving.value = true;
    var name = nameController.text.trim();
    var desc = descController.text.trim();
    if (name.isEmpty || desc.isEmpty) {
      isSaving.value = false;
      Get.snackbar(
        "Error",
        "Please enter both Name and Description",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    var position = await locationProvider.getCurrentLocation();

    if (position == null) {
      isSaving.value = false;
      Get.snackbar(
        "Location Error",
        "Could not fetch location. Please enable GPS and try again.",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    var geoItem = GeoTaggedItem(
      name: name,
      description: desc,
      imagePath: selectedImage.value?.path,
      latitude: position.latitude,
      longitude: position.longitude,
    );
    // Add to list
    geoTaggedItems.add(geoItem);
    await dataProvider.saveGeoTaggedItems(
      geoTaggedItems,
    ); // Save using DataService

    // Clear fields after successful save
    clearFields();
    Get.back();
    saveDataAsJson();

    // Delay Snackbar to ensure visibility after closing bottom sheet
    isSaving.value = false;
    Future.delayed(Duration(milliseconds: 200), () {
      Get.snackbar(
        "Location Saved",
        "Lat: ${position.latitude}, Lng: ${position.longitude}",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    });
    isSaving.value = false;
  }

  //Edit a item in a list
  Future<void> editGeoTaggedItem(
    int index,
    String newName,
    String newDesc,
  ) async {
    geoTaggedItems[index] = geoTaggedItems[index].copyWith(
      name: newName,
      description: newDesc,
    );
    geoTaggedItems.refresh(); // Ensure UI updates
    await dataProvider.saveGeoTaggedItems(geoTaggedItems);
  }

  // Delete a item from List

  Future<void> deleteGeotaggedItem(int index) async {
    geoTaggedItems.removeAt(index);
    await dataProvider.saveGeoTaggedItems(geoTaggedItems);
  }

  // Function to convert list to JSON and print it
  void saveDataAsJson() {
    final jsonData = BaseResponse(geoTaggedItems: geoTaggedItems).toJson();
    log(jsonEncode(jsonData), name: _name); // Print formatted JSON
  }

  void clearFields() {
    nameController.clear();
    descController.clear();
    selectedImage.value = null;
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
    if (mapPermissions[Permission.location] == PermissionStatus.granted) {
      await locationProvider.ensureGpsEnabled();
    }
  }

  @override
  void onReady() {
    super.onReady();
    permissionCheck();
  }

  void onClickFabIcon() async {
    if (!await PermissionService.requestAllPermissions()) {
      Get.snackbar(
        "Permissions Required",
        "Please grant all permissions (Camera, Gallery, Location) to continue.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    print('Opening bottom sheet');
    openBottomSheet(Get.context!);
  }
}
