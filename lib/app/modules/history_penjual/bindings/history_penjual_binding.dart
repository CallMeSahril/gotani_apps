import 'package:get/get.dart';

import '../controllers/history_penjual_controller.dart';

class HistoryPenjualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPenjualController>(
      () => HistoryPenjualController(),
    );
  }
}
