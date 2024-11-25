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
    emailController.text = 'tajib@gmail.com';
    passwordController.text = '12345678';
  }

  login() async {
    try {
      authService.login(emailController.text, passwordController.text).then((val) {
        debugPrint(val.toString());
        tokenManager.saveToken(val['token']);
        roleManager.saveRole(val['role']);
        if (val['role'] == 'seller') {
          log('Goto dashboard admin');
          Get.offAllNamed(Routes.DASHBOARDPENJUAL);
        } else if (val['role'] == 'user') {
          log('Goto dashboard customer');
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          log('role not found');
        }
      });
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
