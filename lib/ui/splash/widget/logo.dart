import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Get.height,
      child: Text(
        'Snap Locator',
        style: GoogleFonts.lilitaOne(color: Color(0xFFFFD700), fontSize: 32.0),
      ),
    );
  }
}
