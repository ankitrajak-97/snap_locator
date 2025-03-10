import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoSavedLocationsWidget extends StatelessWidget {
  const NoSavedLocationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: GoogleFonts.roboto(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
