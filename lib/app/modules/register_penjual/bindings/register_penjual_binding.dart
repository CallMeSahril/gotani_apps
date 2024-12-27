import 'package:get/get.dart';

import '../controllers/register_penjual_controller.dart';

class RegisterPenjualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPenjualController>(
      () => RegisterPenjualController(),
    );
  }
}
