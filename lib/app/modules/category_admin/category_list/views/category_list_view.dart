import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/constants/colors.dart';
import 'package:gotani_apps/app/modules/category_admin/category_list/widgets/category_card.dart';
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
            appBar: AppBar(
              title: const Text('CategoryListView'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.categories.length,
                      itemBuilder: (context, index) {
                        final category = controller.categories[index];
                        return CategoryCard(
                          image: category['image'],
                          name: category['name'],
                          description: category['description'],
                          stock: category['stock'],
                          warning: category['warning'],
                        );
                      },
                    ),
                  ),
                ],
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
