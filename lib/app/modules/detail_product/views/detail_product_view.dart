import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  const DetailProductView({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff0E803C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                padding: EdgeInsets.all(width * 0.05),
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.navigate_before_rounded,
                    size: width * 0.2,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: width * 0.8,
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.05)),
                child: Image.network(
                  controller.product.value.imageUrl ?? "-",
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.warning,
                    size: width * 0.5,
                  ),
                ),
              ),
              SizedBox(
                height: width * 0.1,
              ),
              Container(
                padding: EdgeInsets.all(width * 0.1),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(width * 0.03),
                          decoration: BoxDecoration(
                              color: Color(0xff472C9D),
                              borderRadius: BorderRadius.circular(width * 0.1)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                '4.5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          controller.product.value.price.toString(),
                          style: TextStyle(
                            color: Color(0xff472C9D),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.product.value.price.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () => controller.decrementQuantity(),
                            ),
                            Obx(() => Text(
                                controller.quantityProductDetail.toString())),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () => controller.incrementQuantity(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: Text(
                        controller.product.value.description ?? "-",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width * 0.05),
                            child: Image.network(
                              controller.product.value.user!.storeLogo ?? "",
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.warning,
                                size: width * 0.1,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.6,
                          child: Text(
                            controller.product.value.user!.storeAddress ?? "-",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff0E803C),
                              borderRadius:
                                  BorderRadius.circular(width * 0.03)),
                          padding: EdgeInsets.all(width * 0.03),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  size: width * 0.1,
                                  color: Colors.white,
                                ),
                                VerticalDivider(),
                                Icon(
                                  Icons.shopping_cart_sharp,
                                  size: width * 0.1,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final response = await http.post(
                              Uri.parse("$mainUrl/cart-items"),
                              body: {
                                "product_id":
                                    controller.product.value.id.toString(),
                                "quantity": controller
                                    .quantityProductDetail.value
                                    .toString()
                              },
                              headers: {
                                HttpHeaders.authorizationHeader:
                                    "Bearer ${prefs.getString("token")}",
                              },
                            );
                            var body = jsonDecode(response.body);
                            if (body['status'] == "success" &&
                                response.statusCode == 200) {
                              Get.snackbar(
                                  "Info", "Berhasil menambahkan Keranjang.");
                              Get.back();
                            } else {
                              Get.snackbar(
                                  "Info", "Gagal Menambahkan Keranjang.");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff0E803C),
                                borderRadius:
                                    BorderRadius.circular(width * 0.03)),
                            padding: EdgeInsets.all(width * 0.03),
                            child: SizedBox(
                              height: width * 0.1,
                              child: Expanded(
                                child: Text(
                                  "Add To Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
