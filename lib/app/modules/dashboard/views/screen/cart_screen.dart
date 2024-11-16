import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/dashboard/controllers/cart_controller.dart';

import '../../../../routes/app_pages.dart';
import 'address_screen.dart';

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
                  onTap: () {
                    Get.toNamed(Routes.ADDRESS);
                  },
                  child: Row(
                    children: [
                      Text(
                        controller.address.address ?? "Pilih Alamat",
                        style: TextStyle(
                          color: Color(0xff0E803C),
                          fontSize: 16,
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
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        controller.address.address ?? "Pilih Pengiriman",
                        style: TextStyle(
                          color: Color(0xff0E803C),
                          fontSize: 16,
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
                        Image.network(item.imageUrl, width: 50),
                      ],
                    ),
                    title: Text(item.name),
                    subtitle: Text('Rp ${item.price.toString()}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () => controller.decrementQuantity(index),
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () => controller.incrementQuantity(index),
                        ),
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
