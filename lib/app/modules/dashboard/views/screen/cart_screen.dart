import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/dashboard/controllers/cart_controller.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../main.dart';
import '../../../../core/components/formatter_price.dart';
import '../../../../core/helper/shared_preferences_helper.dart';
import '../../../../routes/app_pages.dart';
import '../../model/model_address.dart';
import '../../model/model_delivery_type.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchCart();
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
      ),
      body: ListView(
        children: [
          Container(
            width: width,
            padding: EdgeInsets.all(width * 0.05),
            alignment: Alignment.centerRight,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    final result = await Get.toNamed(Routes.ADDRESS);

                    if (result != null && result is ModelAddress) {
                      controller.address.value = result;
                      controller.address.refresh();
                      print(
                          "Selected Address: ${controller.address.value.address}");
                    } else {
                      print("No address selected");
                    }
                  },
                  child: Row(
                    children: [
                      Obx(
                        () => Text(
                          controller.address.value.address ?? "Pilih Alamat",
                          style: TextStyle(
                            color: Color(0xff0E803C),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Icon(
                        Icons.navigate_next_outlined,
                        size: width * 0.05,
                        color: Color(0xff0E803C),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: width * 0.04,
                ),
                InkWell(
                  onTap: () async {
                    if (controller.address.value.address == null) {
                      Get.snackbar(
                          "Info", "Mohon pilih alamat terlebih dahulu");
                      return;
                    } else if (controller.cartItems
                        .where((item) => item.isSelected == true)
                        .isEmpty) {
                      Get.snackbar("Warning", "Pilih 1 keranjang");
                    } else if (controller.cartItems
                            .where((item) => item.isSelected == true)
                            .length >
                        1) {
                      Get.snackbar("Warning", "Pilih minimal 1 keranjang");
                    } else {
                      final result =
                          await Get.toNamed(Routes.DELIVERY, arguments: [
                        controller.cartItems
                            .where((item) => item.isSelected == true)
                            .first
                            .productId
                            .toString(),
                        controller.cartItems
                            .where((item) => item.isSelected == true)
                            .first
                            .quantity,
                        controller.address.value.cityId
                      ]);

                      if (result != null && result is ModelDeliveryType) {
                        controller.deliveryType.value = result;
                        controller.deliveryType.refresh();
                        controller.shippingFee.value = result.cost![0].value!;
                        print("Shipping Price = ${result.cost![0].value!}");
                        print(
                            "Selected Delivery: ${controller.deliveryType.value.service}");
                      } else {
                        print("No Delivery selected");
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Obx(
                        () => Text(
                          controller.deliveryType.value.service ??
                              "Pilih Pengiriman",
                          style: TextStyle(
                            color: Color(0xff0E803C),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.04,
                      ),
                      Icon(
                        Icons.navigate_next_outlined,
                        size: width * 0.05,
                        color: Color(0xff0E803C),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.isloading.value
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.cartItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.cartItems[index];
                      return ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: item.isSelected,
                              onChanged: (value) =>
                                  controller.toggleSelection(index),
                            ),
                            Image.network(item.product!.imageUrl ?? "",
                                width: 50),
                          ],
                        ),
                        title: Text(item.product!.name ?? ""),
                        subtitle: Text(
                            Formatter.formatToRupiah(item.product!.price ?? 0)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () => controller.decrementQuantity(
                                index,
                                () async {
                                  final token = await TokenManager().getToken();
                                  final response = await http.put(
                                    Uri.parse("$mainUrl/cart-items/${item.id}"),
                                    body: {
                                      "quantity": item.quantity.toString()
                                    },
                                    headers: {
                                      HttpHeaders.authorizationHeader:
                                          "Bearer $token",
                                    },
                                  );
                                },
                              ),
                            ),
                            Text(item.quantity.toString()),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () => controller.incrementQuantity(
                                index,
                                () async {
                                  final token = await TokenManager().getToken();
                                  final response = await http.put(
                                    Uri.parse("$mainUrl/cart-items/${item.id}"),
                                    body: {
                                      "quantity": item.quantity.toString()
                                    },
                                    headers: {
                                      HttpHeaders.authorizationHeader:
                                          "Bearer $token",
                                    },
                                  );
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final token = await TokenManager().getToken();
                                final response = await http.delete(
                                  Uri.parse("$mainUrl/cart-items/${item.id}"),
                                  headers: {
                                    HttpHeaders.authorizationHeader:
                                        "Bearer $token",
                                  },
                                );
                                print("$mainUrl/cart-items/${item.id}");
                                print("Bearer $token");
                                print(response.body);
                                var body = jsonDecode(response.body);
                                if (body['status'] == "success") {
                                  Get.snackbar(
                                      "Info", "Berhasil Menghapus Keranjang.");
                                  controller.fetchCart();
                                } else {
                                  Get.snackbar(
                                      "Info", "Gagal Menghapus Keranjang.");
                                }
                              },
                              icon: Icon(Icons.delete),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pilih Metode Pembayaran",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(() => ListTile(
                    title: Text("Dana"),
                    leading: Radio<String>(
                      value: "Dana",
                      groupValue: controller.selectedPaymentMethod.value,
                      onChanged: (value) {
                        controller.updatePaymentMethod(value!);
                        Get.snackbar(
                          "Metode Pembayaran",
                          "Metode yang dipilih: $value",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    ),
                  )),
              Obx(
                () => ListTile(
                  title: Text("COD"),
                  leading: Radio<String>(
                    value: "COD",
                    groupValue: controller.selectedPaymentMethod.value,
                    onChanged: (value) {
                      controller.updatePaymentMethod(value!);
                      Get.snackbar(
                        "Metode Pembayaran",
                        "Metode yang dipilih: $value",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Biaya Pengiriman'),
                    Obx(() => Text(Formatter.formatToRupiah(
                        controller.shippingFee.value))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Obx(
                      () => Text(
                        Formatter.formatToRupiah(controller.subtotal),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 18)),
                    Obx(
                      () => Text(
                        Formatter.formatToRupiah(controller.total),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final token = await TokenManager().getToken();

                    if (controller.cartItems
                        .where((item) => item.isSelected == true)
                        .isEmpty) {
                      Get.snackbar("Warning", "Pilih 1 keranjang");
                      return;
                    } else if (controller.cartItems
                            .where((item) => item.isSelected == true)
                            .length <
                        1) {
                      Get.snackbar("Warning", "Pilih minimal 1 keranjang");
                      return;
                    } else if (controller.address.value.address == null) {
                      Get.snackbar("Warning", "Pilih Alamat");
                      return;
                    } else if (controller.deliveryType.value.service == null) {
                      Get.snackbar("Warning", "Pilih Pegiriman");
                      return;
                    } else if (controller.selectedPaymentMethod.value == "") {
                      Get.snackbar("Warning", "Pilih Metode Pembayaran");
                      return;
                    } else {
                      print({
                        "product_id": controller.cartItems
                            .firstWhere((item) => item.isSelected == true)
                            .productId
                            .toString(),
                        "quantity": controller.cartItems
                            .firstWhere((item) => item.isSelected == true)
                            .quantity
                            .toString(),
                        "total": controller.total.toString(),
                        "payment_method": controller.selectedPaymentMethod.value
                      }.toString());
                      final response = await http.post(
                        Uri.parse("$mainUrl/transaction"),
                        body: {
                          "product_id": controller.cartItems
                              .firstWhere((item) => item.isSelected == true)
                              .productId
                              .toString(),
                          "quantity": controller.cartItems
                              .firstWhere((item) => item.isSelected == true)
                              .quantity
                              .toString(),
                          "total": controller.total.toString(),
                          "payment_method":
                              controller.selectedPaymentMethod.value
                        },
                        headers: {
                          HttpHeaders.authorizationHeader: "Bearer $token",
                        },
                      );
                      var body = jsonDecode(response.body);
                      if (body['status'] == "success" &&
                          response.statusCode == 200) {
                        print(response.body);
                        if (body['data']['payment_url'] != null) {
                          final paymentUrl = body['data']['payment_url'];
                          if (await canLaunchUrl(Uri.parse(paymentUrl))) {
                            await launchUrl(Uri.parse(paymentUrl));
                          } else {
                            throw 'Could not launch $paymentUrl';
                          }
                          print("Payment URL: $paymentUrl");
                        }
                        Get.offAllNamed(Routes.DASHBOARD);
                      } else {
                        Get.snackbar("Info", "Gagal Melakukan Transaksi.");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Pesan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
