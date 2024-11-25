import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/components/card_product.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/model/model_product.dart';
import '../controllers/search_products_controller.dart';

class SearchProductsView extends GetView<SearchProductsController> {
  const SearchProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.9,
                padding: EdgeInsets.all(width * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomTextField(
                  prefixIcon: Icon(Icons.search),
                  isBorder: false,
                  controller: TextEditingController(),
                  label: "Search",
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Obx(
                () => Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.center,
                  children: [
                    for (var produk in controller.listProduct)
                      CardProduct(
                        link: () async {
                          ModelProduct data =
                              await ModelProduct.fetchDetailsRecords(
                                  id: produk.id.toString());
                          Get.toNamed(Routes.DETAIL_PRODUCT, arguments: data);
                        },
                        image: produk.imageUrl ?? "",
                        text: produk.name ?? "",
                      ),
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
