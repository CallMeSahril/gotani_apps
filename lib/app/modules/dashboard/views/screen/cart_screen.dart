import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gotani_apps/app/modules/dashboard/controllers/cart_controller.dart';

import '../../../../../main.dart';
import '../../../../routes/app_pages.dart';
import '../../model/model_address.dart';
import '../../model/model_delivery_type.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
      ),
      body: Column(
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
                        .any((item) => item.isSelected == true)) {
                      Get.snackbar("Info", "Mohon pilih item terlebih dahulu");
                      return;
                    } else {
                      final result = await Get.toNamed(Routes.ADDRESS);

                      if (result != null && result is ModelDeliveryType) {
                        controller.deliveryType.value = result;
                        controller.deliveryType.refresh();
                        print(
                            "Selected Delivery: ${controller.address.value.address}");
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
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.cartItems.length,
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
                        Image.network(item.product!.imageUrl ?? "", width: 50),
                      ],
                    ),
                    title: Text(item.product!.name ?? ""),
                    subtitle: Text('Rp ${item.product!.price.toString()}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () => controller.decrementQuantity(
                            index,
                            () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final response = await http.put(
                                Uri.parse("$mainUrl/cart-items/${item.cartId}"),
                                body: {"quantity": item.quantity.toString()},
                                headers: {
                                  HttpHeaders.authorizationHeader:
                                      "Bearer ${prefs.getString("token")}",
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
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final response = await http.put(
                                Uri.parse("$mainUrl/cart-items/${item.cartId}"),
                                body: {"quantity": item.quantity.toString()},
                                headers: {
                                  HttpHeaders.authorizationHeader:
                                      "Bearer ${prefs.getString("token")}",
                                },
                              );
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final response = await http.delete(
                              Uri.parse("$mainUrl/cart-items/${item.id}"),
                              headers: {
                                HttpHeaders.authorizationHeader:
                                    "Bearer ${prefs.getString("token")}",
                              },
                            );

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
                    Text('Rp ${controller.shippingFee}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Obx(
                      () => Text(
                        'Rp ${controller.subtotal}',
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
                        'Rp ${controller.total}',
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Pesan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
