import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snap_locator/component/noLocationSavedWidget.dart';
import 'package:snap_locator/ui/home/widget/image_view.dart';
import 'package:snap_locator/utils/style/app_color.dart';
import 'package:snap_locator/utils/style/app_dimen.dart';

import '../controller/home_controller.dart';
import 'edit_items_sheet.dart';

class HomeView extends StatelessWidget {
  static const name = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kHeight * 8),
        child: Container(
          decoration: BoxDecoration(
            color: kBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 4,
                offset: Offset(0, 4), // Shadow effect
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Geo Tags",
                    style: GoogleFonts.lilitaOne(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      // Open settings
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        return Visibility(
          visible: controller.geoTaggedItems.isNotEmpty,
          replacement: NoSavedLocationsWidget().paddingSymmetric(
            horizontal: 24,
          ),
          child: ListView.builder(
            itemCount: controller.geoTaggedItems.length,
            itemBuilder: (context, index) {
              final item = controller.geoTaggedItems[index];
              return Card(
                child: ListTile(
                  leading:
                      item.imagePath != null
                          ? GestureDetector(
                            onTap: () {
                              Get.to(
                                () => FullScreenImageView(
                                  imagePath: item.imagePath!,
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(item.imagePath!),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          : Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ), // Default icon if no image

                  title: Text(item.name),
                  subtitle: Text(item.description),
                  trailing: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.location_on, color: Colors.red),
                        onPressed: () {
                          controller.openGoogleMaps(
                            item.latitude,
                            item.longitude,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.red),
                        onPressed: () {
                          Get.bottomSheet(
                            EditGeoTaggedBottomSheet(
                              index: index,
                              item: controller.geoTaggedItems[index],
                            ),
                            isScrollControlled:
                                true, // Allows full-height bottom sheet
                            backgroundColor:
                                Colors.white, // Optional: Ensures visibility
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Confirm Delete",
                            middleText:
                                "Are you sure you want to delete this item?",
                            textConfirm: "Yes",
                            textCancel: "No",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              controller.deleteGeotaggedItem(index);
                              Get.back(); // Close dialog
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onClickFabIcon();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
