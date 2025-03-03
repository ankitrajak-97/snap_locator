import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../permissions/permission_helper.dart';
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  static const name = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text("Geo Tagged Items")),
      body: Obx(() {
        return controller.geoTaggedItems.isEmpty
            ? const Center(
              child: Text(
                "No items added.\nClick + to add.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
            : ListView.builder(
              itemCount: controller.geoTaggedItems.length,
              itemBuilder: (context, index) {
                final item = controller.geoTaggedItems[index];
                return Card(
                  child: ListTile(
                    leading:
                        item.imagePath != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(
                                  item.imagePath!,
                                ), // Convert path back to File
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ), // Default icon if no image

                    title: Text(item.name),
                    subtitle: Text(item.description),
                    trailing: IconButton(
                      icon: Icon(Icons.location_on, color: Colors.red),
                      onPressed: () {
                        controller.openGoogleMaps(
                          item.latitude,
                          item.longitude,
                        );
                      },
                    ),
                  ),
                );
              },
            );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool allPermissionsGranted =
              await PermissionHelper.requestAllPermissions();

          if (allPermissionsGranted) {
            print('opening bottomsheet');
            controller.openBottomSheet(context);
          } else {
            Get.snackbar(
              "Permissions Required",
              "Please grant all permissions (Camera, Gallery, Location) to continue.",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
