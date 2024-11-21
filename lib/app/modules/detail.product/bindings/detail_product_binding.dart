import 'package:get/get.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductPenjualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductPenjualController>(
      () => DetailProductPenjualController(),
    );
  }
}
