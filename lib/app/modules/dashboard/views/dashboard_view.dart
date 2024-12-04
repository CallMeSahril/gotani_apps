import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/account_screen.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/cart_screen.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/home_dashboard_screen.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/chat_messages_screen.dart';
import 'package:gotani_apps/app/modules/dashboard/views/screen/notification_screen.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            HomeDashboardScreen(),
            ChatMessagesScreen(),
            NotificationScreen(),
            CartScreen(),
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
              icon: Icon(Icons.message_outlined),
              label: 'Messages',
              activeIcon: Icon(Icons.message),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
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
