import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/admin_product/product/controllers/product_controller.dart';

import '../controllers/form_product_controller.dart';

class FormProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormProductController>(
      () => FormProductController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
  }
}
