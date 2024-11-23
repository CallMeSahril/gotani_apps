import 'package:get/get.dart';

class HomeController extends GetxController {
  final totalSales = 10000000.obs;
  final productCount = 100.obs;
  final newOrders = 20.obs;

  final analytics = {
    'Bibit': 65.0,
    'Pupuk': 80.0,
    'Racun': 50.0,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    // get token from storage
  }
}
