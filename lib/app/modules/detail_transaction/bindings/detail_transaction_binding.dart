import 'package:get/get.dart';

import '../controllers/detail_transaction_controller.dart';

class DetailTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTransactionController>(
      () => DetailTransactionController(),
    );
  }
}
