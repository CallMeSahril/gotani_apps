import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/product.service.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

class DetailProductAdminController extends GetxController {
  final dynamic product = Get.arguments['product'];
  final Map user = Get.arguments['user'];

  void deleteProduct() {
    final productService = ProductService();
    productService.deleteProduct(product['id']).then((value) {
      if (value) {
        Get.back();
      }
    });
  }

  editProduct() {
    Get.toNamed(Routes.EDIT_PRODUK, arguments: {
      'product_id': product['id'],
    });
  }
}
