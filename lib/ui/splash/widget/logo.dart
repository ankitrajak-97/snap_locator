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
      child: Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(topLeft: Radius.circular(kRadius)),
        // ),
        color: const Color(0xFF330867),
        child: Text(
          'Snap Locator',
          style: GoogleFonts.lilitaOne(color: Colors.white, fontSize: 32.0),
        ),
      ),
    );
  }
}
