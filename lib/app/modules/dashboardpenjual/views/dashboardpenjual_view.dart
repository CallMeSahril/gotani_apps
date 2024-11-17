import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/admin_category/category_list/views/category_list_view.dart';
import 'package:gotani_apps/app/modules/admin_notification/admin_notifications/views/admin_notifications_view.dart';
import 'package:gotani_apps/app/modules/admin_product/product/views/product_view.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/account_screen.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/cart_screen.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/chat_messages_screen.dart';
import 'package:gotani_apps/app/modules/home/views/home_view.dart';

import '../controllers/dashboardpenjual_controller.dart';

class DashboardpenjualView extends GetView<DashboardpenjualController> {
  const DashboardpenjualView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomeView(),
            ProductView(),
            CategoryListView(),
            AdminNotificationsView(),
            ChatMessagesScreen(),
            AccountScreen(),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          backgroundColor: Colors.white,
          selectedItemColor:
              Color(0xff1F6751), // Set the color for the selected item
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Produk',
              activeIcon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Category',
              activeIcon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_sharp),
              label: 'Pesan',
              activeIcon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        );
      }),
    );
  }
}
