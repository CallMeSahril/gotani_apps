import 'package:get/get.dart';

import '../controllers/admin_detail_notifications_controller.dart';

class AdminDetailNotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDetailNotificationsController>(
      () => AdminDetailNotificationsController(),
    );
  }
}
