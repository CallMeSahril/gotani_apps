import 'package:get/get.dart';

class DashboardpenjualController extends GetxController {
  //TODO: Implement DashboardController

  final count = 0.obs;
  final selectedIndex = 0.obs; // New property for navbar index

  @override
  void onInit() {
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
