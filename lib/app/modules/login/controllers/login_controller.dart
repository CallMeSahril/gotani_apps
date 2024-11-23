import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/app/core/services/auth.service.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();
  var isEyes = true.obs;
  var isLoading = false.obs;
  TokenManager tokenManager = TokenManager();
  RoleManager roleManager = RoleManager();

  @override
  void onInit() {
    super.onInit();
    emailController.text = 'penjual@gmail.com';
    passwordController.text = "penjual123";
  }

  login() async {
    try {
      isLoading.value = true;
      await authService.login(emailController.text, passwordController.text).then((val) {
        if (val != null) {
          tokenManager.saveToken(val['token']);
          roleManager.saveRole(val['role']);
          if (val['role'] == 'seller' || emailController.text == 'penjual1@gmail.com') {
            isLoading.value = false;
            Get.offAllNamed(Routes.DASHBOARDPENJUAL);
          } else if (val['role'] == 'seller' || emailController.text == 'pembeli@gmail.com') {
            log('Goto dashboard customer');
            Get.offAllNamed(Routes.DASHBOARD);
          } else {
            log('role not found');
          }
        } else {
          isLoading.value = false;
          Get.snackbar('Error', val.toString());
        }
      });
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
