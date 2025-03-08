import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snap_locator/ui/splash/widget/logo.dart';
import 'package:snap_locator/utils/style/app_color.dart';
import 'package:snap_locator/utils/style/app_dimen.dart';

import '../controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  static const name = '/splash';
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
      appBar: AppBar(backgroundColor: kBackgroundColor, toolbarHeight: 0),
      backgroundColor: kBackgroundColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SplashLogo(),
          Positioned(
            bottom: kHeight * 8,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3.0,
            ),
          ),
        ],
      ),
    );
  }
}
