import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snap_locator/utils/style/app_color.dart';
import 'package:snap_locator/utils/style/app_dimen.dart';

import '../controller/home_controller.dart';

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
        return controller.geoTaggedItems.isEmpty
            ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_off, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  "No locations saved yet!",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Tap the '+' button to start adding geo-tagged places.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 24)
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
        onPressed: () {
          controller.onClickFabIcon();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
