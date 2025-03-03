import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snap_locator/utils/style/app_color.dart';

import '../controller/home_controller.dart';

class GeoTaggedInput extends StatelessWidget {
  const GeoTaggedInput({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Heading
              Text(
                "Add a Geo Item",
                style: GoogleFonts.nanumGothic(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Name *',
                  hintText: 'Enter Name here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.descController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description *',
                  hintText: 'Enter description here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Image Picker
              Obx(() {
                return InkWell(
                  onTap: () {
                    controller.showImagePickerOptions(
                      context,
                    ); // Call Controller Function
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.grey[200],
                    ),
                    child:
                        controller.selectedImage.value != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Image.file(
                                File(controller.selectedImage.value!.path),
                                fit: BoxFit.cover,
                              ),
                            )
                            : const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text("Tap to pick an image"),
                                ],
                              ),
                            ),
                  ),
                );
              }),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  controller.saveGeoTaggedItem();
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
