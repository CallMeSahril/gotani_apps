import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/constants/colors.dart';
import 'package:gotani_apps/app/modules/admin_category/category_list/widgets/category_card.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

import '../controllers/category_list_controller.dart';

class CategoryListView extends GetView<CategoryListController> {
  const CategoryListView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CategoryListController(),
        builder: (controler) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.fetchProfile();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            return GestureDetector(
                              onTap: () {
                                controler.listTap(category);
                              },
                              child: CategoryCard(
                                image: category['image'],
                                name: category['name'],
                                description: category['description'],
                                stock: category['stock'],
                                warning: category['warning'],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.toNamed(Routes.CATEGORY_FORM);
              },
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          );
        });
  }
}
