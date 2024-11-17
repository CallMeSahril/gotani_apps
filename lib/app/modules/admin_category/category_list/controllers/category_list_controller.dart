import 'dart:developer';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/auth.service.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

class CategoryListController extends GetxController {
  final List<Map<String, dynamic>> categories = [
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Bibit',
      'description': 'Stok Bibit Hampir Habis Segera Input Ulang!',
      'stock': 10,
      'warning': true,
    },
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Pupuk',
      'description': 'Stok Pupuk Melimpah',
      'stock': 10,
      'warning': false,
    },
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Racun',
      'description': 'Stok Bibit Hampir Habis Segera Input Ulang!',
      'stock': 10,
      'warning': true,
    },
    {
      'image': 'https://placehold.co/1920x1080',
      'name': 'Alat Tani',
      'description': 'Stok Alat Tani Melimpah',
      'stock': 10,
      'warning': false,
    },
  ];

  Map user = {};

  void fetchProfile() {
    final authService = AuthService();
    authService.getProfile().then((value) {
      if (value != null) {
        user.addAll(value);
        update();
      }
      log(value.toString());
    }).catchError((error) {
      print('Error fetching profile: $error');
    });
  }

  listTap(Map category) {
    Get.toNamed(Routes.CATEGORY_FORM, arguments: category);
  }
}
