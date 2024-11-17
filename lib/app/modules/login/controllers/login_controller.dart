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

  TokenManager tokenManager = TokenManager();
  RoleManager roleManager = RoleManager();

  @override
  void onInit() {
    super.onInit();
    emailController.text = 'penjual@gmail.com';
    passwordController.text = "penjual123";
  }

  login() {
    try {
      authService
          .login(emailController.text, passwordController.text)
          .then((val) {
        tokenManager.saveToken(val['token']);
        roleManager.saveRole(val['role']);
        if (val['role'] == 'seller') {
          log('Goto dashboard admin');
          Get.offAllNamed(Routes.HOME);
        } else if (val['role'] == 'customer') {
          log('Goto dashboard customer');
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          log('role not found');
        }
      });
    } catch (e) {
      // Handle error
    }
  }
}
