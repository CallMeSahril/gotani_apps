import 'package:get/get.dart';

class DetailProductController extends GetxController {
  final data = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    print(Get.arguments);
  }
}
