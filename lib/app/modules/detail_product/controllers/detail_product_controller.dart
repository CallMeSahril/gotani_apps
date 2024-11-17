import 'package:get/get.dart';

import '../../dashboard/model/model_product.dart';

class DetailProductController extends GetxController {
  //TODO: Implement DetailProductController
  Rx<ModelProduct> product = ModelProduct().obs;
  RxInt quantityProductDetail = 1.obs;

  @override
  void onInit() {
    super.onInit();
    product.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void incrementQuantity() {
    quantityProductDetail++;
    quantityProductDetail.refresh();
  }

  void decrementQuantity() {
    if (quantityProductDetail > 1) {
      quantityProductDetail--;
      quantityProductDetail.refresh();
    }
  }
}
