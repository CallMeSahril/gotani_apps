import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/components/buttons.dart';
import 'package:gotani_apps/app/core/constants/colors.dart';
import 'package:gotani_apps/app/core/helper/format_currency.dart';
import 'package:gotani_apps/app/modules/product_admin/detail_product_admin/controllers/detail_product_admin_controller.dart';
import 'package:gotani_apps/app/modules/product_admin/product/controllers/product_controller.dart';

class DetailProductAdminView extends GetView<DetailProductAdminController> {
  const DetailProductAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DetailProductAdminController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              final product = Get.find<ProductController>();
              product.getData();
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: Get.height * 55 / 100,
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.subtitle,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 10 / 100),
                        // Image product
                        Container(
                          height: Get.height * 25 / 100,
                          width: Get.width * 60 / 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: controller.product['image_url'],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 37 / 100),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add to cart',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),

                  // Body
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 43 / 100),
                        Container(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                          height: Get.height * 60 / 100,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // card ratting
                                    Container(
                                      height: 52,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 24,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            controller.product['rating']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Rp ${formatCurrency(controller.product['price'])}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Titel Product
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.product['name'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),

                                // Description
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      controller.product['description'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // cart location
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.user['store_logo'],
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  title: Text(
                                    controller.user['store_name'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Text(
                                    controller.user['store_address'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),

                                SizedBox(
                                  height: 50,
                                ),

                                // button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 54,
                                      width: Get.width * 40 / 100,
                                      child: Button.filled(
                                        onPressed: () {
                                          controller.editProduct();
                                        },
                                        label: "Edit Prdouk",
                                        textColor: Colors.white,
                                        color: AppColors.primary,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 54,
                                      width: Get.width * 40 / 100,
                                      child: Button.filled(
                                        onPressed: () {
                                          controller.deleteProduct();
                                        },
                                        label: "Hapus Produk",
                                        textColor: Colors.white,
                                        color: AppColors.red,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Button arrow back
                  Positioned(
                    left: 16,
                    top: 35,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.white,
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
