import 'package:get/get.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  final count = 0.obs;
  final selectedIndex = 0.obs; // New property for navbar index

  @override
  void onInit() {
    if (Get.arguments != null) {
      selectedIndex.value = Get.arguments as int;
    }
    super.onInit();
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

  void onItemTapped(int index) {
    // New method for navbar item tap
    selectedIndex.value = index;
  }
}
