import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_product_seller_controller.dart';

class DetailProductSellerView extends GetView<DetailProductSellerController> {
  const DetailProductSellerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailProductSellerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailProductSellerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
