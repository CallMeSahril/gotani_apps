import 'package:get/get.dart';

class DetailProductPenjualController extends GetxController {
  final data = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    print(Get.arguments);
  }
}
