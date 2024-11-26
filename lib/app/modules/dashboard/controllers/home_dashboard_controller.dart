import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/model_category.dart';
import '../model/model_product.dart';

class HomeDashboardController extends GetxController {
  TextEditingController controllerSearch = TextEditingController();
  RxList<ModelCategory> listCategori = <ModelCategory>[].obs;
  // RxList<Map<String, dynamic>> listCategori = [
  //   {
  //     "icon": 'assets/images/bibit.png',
  //     "name": "Bibit",
  //   },
  //   {
  //     "icon": 'assets/images/pupuk.png',
  //     "name": "Pupuk",
  //   },
  //   {
  //     "icon": 'assets/images/racun.png',
  //     "name": "Racun",
  //   },
  //   {
  //     "icon": 'assets/images/alat_tani.png',
  //     "name": "Alat Tani",
  //   }
  // ].obs;

  RxList<ModelProduct> listProduct = <ModelProduct>[].obs;
  RxList<ModelProduct> listPopularProduct = <ModelProduct>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchProducts();
    fetchCategory();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchProducts() {
    ModelProduct.fetchRecords().then((value) {
      listProduct.value = value;
      listProduct.refresh();
    });
  }

  fetchCategory() {
    ModelCategory.fetchCategory().then((value) {
      listCategori.value = value;
      listCategori.refresh();
    });
  }
}
