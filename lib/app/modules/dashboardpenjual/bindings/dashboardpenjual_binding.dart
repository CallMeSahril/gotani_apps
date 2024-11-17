import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/admin_category/category_list/controllers/category_list_controller.dart';
import 'package:gotani_apps/app/modules/admin_notification/admin_notifications/controllers/admin_notifications_controller.dart';
import 'package:gotani_apps/app/modules/admin_product/product/controllers/product_controller.dart';
import 'package:gotani_apps/app/modules/dashboard/controllers/account_controller.dart';
import 'package:gotani_apps/app/modules/dashboard/controllers/cart_controller.dart';
import 'package:gotani_apps/app/modules/dashboard/controllers/chat_messages_controller.dart';
import 'package:gotani_apps/app/modules/home/controllers/home_controller.dart';

import '../controllers/dashboardpenjual_controller.dart';

class DashboardpenjualBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardpenjualController>(
      () => DashboardpenjualController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<CategoryListController>(
      () => CategoryListController(),
    );
    Get.lazyPut<AdminNotificationsController>(
      () => AdminNotificationsController(),
    );

    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );

    Get.lazyPut<ChatMessagesController>(
      () => ChatMessagesController(),
    );
  }
}
