import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/model/model_product.dart';

class SearchProductsController extends GetxController {
  //TODO: Implement SearchProductsController
  TextEditingController controllerSearch = TextEditingController();
  var query = "".obs;
  var isLoading = false.obs;
  RxList<ModelProduct> listProduct = <ModelProduct>[].obs;

  fetchSearchProduct(String query) async {
    await ModelProduct.searchProduct(query).then((value) {
      listProduct.value = value;
      listProduct.refresh();
    });
  }

  @override
  void onInit() {
    super.onInit();
    query.value = Get.arguments;
    controllerSearch.text = Get.arguments;
    fetchSearchProduct(query.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
