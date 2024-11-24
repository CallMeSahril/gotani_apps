import 'package:get/get.dart';

import '../controllers/detail_product_seller_controller.dart';

class DetailProductSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductSellerController>(
      () => DetailProductSellerController(),
    );
  }
}
