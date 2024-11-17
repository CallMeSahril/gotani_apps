import 'dart:developer';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/auth.service.dart';
import 'package:gotani_apps/app/core/services/product.service.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  List products = [];

  final user = {};
  bool isLoading = true;

  bool isAvailable = true;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    fetchAllProductsAdmin();
    fetchProfile();
  }

  Future<void> fetchAllProductsAdmin() async {
    try {
      isLoading = true;
      update();
      products = await _productService.getAllProductsAdmin();
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

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

  onSelectItem(dynamic product) {
    if (product != null) {
      // Jika product tidak null, navigasikan ke halaman detail
      Get.toNamed(Routes.DETAIL_PRODUCT_ADMIN,
          arguments: {"product": product, "user": user});
    } else {
      // Berikan log atau penanganan jika product null
      print("Product is null!");
    }
  }
}
