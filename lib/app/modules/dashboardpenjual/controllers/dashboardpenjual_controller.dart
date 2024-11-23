import 'package:get/get.dart';

class DashboardpenjualController extends GetxController {
  final count = 0.obs;
  final selectedIndex = 0.obs; // New property for navbar index

  void increment() => count.value++;

  void onItemTapped(int index) {
    // New method for navbar item tap
    selectedIndex.value = index;
  }
}
