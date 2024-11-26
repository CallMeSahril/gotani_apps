import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/components/card_product.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/model/model_product.dart';
import '../controllers/category_products_controller.dart';

class CategoryProductsView extends GetView<CategoryProductsController> {
  const CategoryProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        centerTitle: true,
      ),
      body: Obx(
        () => Wrap(
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.center,
          children: [
            for (var produk in controller.listProduct)
              CardProduct(
                link: () async {
                  ModelProduct data = await ModelProduct.fetchDetailsRecords(
                      id: produk.id.toString());
                  Get.toNamed(Routes.DETAIL_PRODUCT, arguments: data);
                },
                image: produk.imageUrl ?? "",
                text: produk.name ?? "",
              ),
          ],
        ),
      ),
    );
  }
}
