import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/auth.service.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  var isEyes = true.obs;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _authService = AuthService();

  bool isLoading = false;
  register() {
    if (usernameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    isLoading = true;
    update();
    _authService
        .register(
      usernameController.text,
      emailController.text,
      passwordController.text,
    )
        .then((value) {
      if (value != null) {
        isLoading = false;
        update();
        Get.offNamed(Routes.LOGIN);
      }
    }).catchError((error) {
      isLoading = false;
      update();
      print(error);
    });
  }
}
