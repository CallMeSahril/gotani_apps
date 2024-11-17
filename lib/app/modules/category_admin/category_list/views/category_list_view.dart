import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/constants/colors.dart';
import 'package:gotani_apps/app/modules/admin_category/category_list/controllers/category_list_controller.dart';
import 'package:gotani_apps/app/modules/admin_category/category_list/widgets/category_card.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

class CategoryListView extends GetView<CategoryListController> {
  const CategoryListView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CategoryListController(),
        builder: (controler) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(Get.width, Get.height * 20 / 100),
              child: Container(
                width: Get.width,
                margin: EdgeInsets.only(top: Get.height * 3.9 / 100),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: 24,
                            ),
                          ),
                          Container(
                            width: Get.width * 80 / 100,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 15),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.user['store_logo'] ??
                                  'https://placehold.co/600x400?text=No+Image',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            controller.user['store_name'] ?? '',
                            style: TextStyle(
                              color: AppColors
                                  .white, // Replace with your actual color
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: RefreshIndicator(
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
