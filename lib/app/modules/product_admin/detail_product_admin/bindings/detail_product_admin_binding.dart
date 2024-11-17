import 'package:get/get.dart';

import '../controllers/detail_product_admin_controller.dart';

class DetailProductAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductAdminController>(
      () => DetailProductAdminController(),
    );
  }
}
