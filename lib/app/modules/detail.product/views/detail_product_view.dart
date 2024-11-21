import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/components/buttons.dart';
import 'package:gotani_apps/app/core/constants/colors.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductPenjualView extends GetView<DetailProductPenjualController> {
  const DetailProductPenjualView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DetailProductPenjualController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
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
                        child: Image.asset(controller.data['icon'],
                            fit: BoxFit.cover),
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
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
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
                                          '4.8',
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Rp.80.000',
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
                                    controller.data['name'],
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 24,
                                    child: Row(children: [
                                      GestureDetector(
                                        onTap: () {
                                          print('remove');
                                        },
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          size: 24,
                                          color: AppColors.blue,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print('add');
                                        },
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: 24,
                                          color: AppColors.blue,
                                        ),
                                      )
                                    ]),
                                  )
                                ],
                              ),

                              // Description
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Mengandung unsur hara yang sangat mudah diserap oleh tanaman.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
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
                                  child: Image.asset(
                                    controller.data['icon'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  'Location',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  'Jl. Kebon Jeruk, Jakarta, Indonesia',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),

                              SizedBox(
                                height: 40,
                              ),

                              // button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 70,
                                      width: Get.width * 40 / 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.primary,
                                      ),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.mail_outline_rounded,
                                                    color: Colors.white),
                                                Text(
                                                  'Pesan',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.trolley,
                                                    color: Colors.white),
                                                Text(
                                                  'Keranjang',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            )
                                          ])),
                                  SizedBox(
                                    height: 70,
                                    width: Get.width * 40 / 100,
                                    child: Button.filled(
                                      onPressed: () {},
                                      label: "Add To Cart",
                                      textColor: Colors.white,
                                      color: AppColors.primary,
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
          );
        });
  }
}
