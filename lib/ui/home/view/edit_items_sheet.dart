import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snap_locator/utils/style/app_dimen.dart';

import '../../../model/geo_tagged_items/geo_tagged_item.dart';
import '../../../utils/style/app_color.dart';
import '../controller/home_controller.dart';

class EditGeoTaggedBottomSheet extends StatelessWidget {
  final int index;
  final GeoTaggedItem item;

  const EditGeoTaggedBottomSheet({
    super.key,
    required this.index,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final TextEditingController nameController = TextEditingController(
      text: item.name,
    );
    final TextEditingController descController = TextEditingController(
      text: item.description,
    );

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kBackgroundColor, // Keep it dark navy
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit Location",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name *',
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                hintText: 'Enter Name here',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: const Color(0xFF1A1A2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ), // Soft grey border
                ),
              ),
            ),
            SizedBox(height: kHeight * 4),
            TextField(
              controller: descController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Description *',
                labelStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                hintText: 'Enter description here',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: const Color(0xFF1A1A2E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(), // Close Bottom Sheet
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.editGeoTaggedItem(
                      index,
                      nameController.text,
                      descController.text,
                    );
                    Get.back(); // Close Bottom Sheet after saving
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
