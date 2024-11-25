import 'package:get/get.dart';

import '../../dashboard/model/model_product.dart';

class SearchProductsController extends GetxController {
  //TODO: Implement SearchProductsController
  var query = "".obs;
  RxList<ModelProduct> listProduct = <ModelProduct>[].obs;

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    query.value = Get.arguments;
    await ModelProduct.fetchRecords().then((value) {
      listProduct.value = value;
      listProduct.refresh();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
