import 'package:get/get.dart';

import '../controllers/form_product_controller.dart';

class FormProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormProductController>(
      () => FormProductController(),
    );
  }
}
