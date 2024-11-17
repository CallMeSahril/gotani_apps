import 'package:get/get.dart';

import '../controllers/category_form_controller.dart';

class CategoryFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryFormController>(
      () => CategoryFormController(),
    );
  }
}
