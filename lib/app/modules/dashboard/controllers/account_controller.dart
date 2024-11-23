import 'dart:developer';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/auth.service.dart';

class AccountController extends GetxController {
  bool isLoading = false;
  Map user = {};

  void fetchProfile() async {
    final authService = AuthService();
    await authService.getProfile().then((value) {
      if (value != null) {
        user.addAll(value);

        update();
      }
    }).catchError((error) {
      print('Error fetching profile: $error');
    });
  }
}
