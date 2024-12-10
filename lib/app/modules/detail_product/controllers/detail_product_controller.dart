import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';
import '../../dashboard/controllers/cart_controller.dart';
import '../../dashboard/model/model_product.dart';

class DetailProductController extends GetxController {
  CartController cartController = Get.put(CartController());
  //TODO: Implement DetailProductController
  Rx<ModelProduct> product = ModelProduct().obs;
  RxInt quantityProductDetail = 1.obs;

  @override
  void onInit() {
    super.onInit();
    product.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void incrementQuantity() {
    quantityProductDetail++;
    quantityProductDetail.refresh();
  }

  void decrementQuantity() {
    if (quantityProductDetail > 1) {
      quantityProductDetail--;
      quantityProductDetail.refresh();
    }
  }

  Future<void> addToCart() async {
    final token = await TokenManager().getToken();
    final response = await http.post(
      Uri.parse("$mainUrl/cart-items"),
      body: {
        "product_id": product.value.id.toString(),
        "quantity": quantityProductDetail.value.toString()
      },
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    print(response.body);
    var body = jsonDecode(response.body);
    print(body['status'] == "success");
    if (body['status'] == "success") {
      Get.back();
      Get.snackbar("Info", "Berhasil menambahkan Keranjang.");
      cartController.fetchCart();
    } else {
      Get.snackbar("Info", "Gagal Menambahkan Keranjang.");
    }
  }
}
