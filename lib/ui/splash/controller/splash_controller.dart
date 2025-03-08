import 'dart:developer';

import 'package:get/get.dart';

import '../../home/view/home_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    log("controller onInit");
  }

  @override
  void onReady() {
    super.onReady();
    log("controller onReady");
    Future.delayed(4.seconds, () {
      Get.off(() => HomeView());
    });
  }

  @override
  void onClose() {
    super.onClose();
    log("controller onClose");
  }
}
