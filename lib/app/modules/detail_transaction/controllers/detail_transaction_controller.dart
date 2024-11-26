import 'package:get/get.dart';

import '../../dashboard/model/model_product.dart';
import '../../dashboard/model/model_transaction.dart';

class DetailTransactionController extends GetxController {
  //TODO: Implement DetailTransactionController
  RxList<ModelProduct> product = <ModelProduct>[].obs;
  Rx<ModelTransaction> transaction = ModelTransaction().obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    transaction.value = Get.arguments[0];
    product.value = Get.arguments[1];
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
