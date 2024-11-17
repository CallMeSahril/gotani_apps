import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('This is Admin Dashboard'),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.CATEGORY_LIST);
                },
                child: const Text('category')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.PRODUCT);
                },
                child: const Text('product')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.ADMIN_NOTIFICATIONS);
                },
                child: const Text('Notification')),
          ],
        ),
      ),
    );
  }
}
