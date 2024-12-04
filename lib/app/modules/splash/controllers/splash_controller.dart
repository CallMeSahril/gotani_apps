import 'dart:async';

import 'package:get/get.dart';

import '../../../core/helper/shared_preferences_helper.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;

  Future<void> check() async {
    print("testing");
    final token = await TokenManager().getToken();
    final role = await RoleManager().getRole();
    Timer(const Duration(seconds: 5), () {
      print(token);
      print(role);
      token == null
          ? Get.toNamed(Routes.SPLASHHOME)
          : role == "user"
              ? Get.toNamed(Routes.DASHBOARD)
              : Get.toNamed(Routes.DASHBOARDPENJUAL);
      ;
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    print("testing");
    check();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
