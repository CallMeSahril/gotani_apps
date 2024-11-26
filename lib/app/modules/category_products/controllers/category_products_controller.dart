import 'package:get/get.dart';

import '../../dashboard/model/model_product.dart';

class CategoryProductsController extends GetxController {
  //TODO: Implement CategoryProductsController
  RxList<ModelProduct> listProduct = <ModelProduct>[].obs;

  @override
  void onInit() {
    super.onInit();
    listProduct.value = Get.arguments;
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
