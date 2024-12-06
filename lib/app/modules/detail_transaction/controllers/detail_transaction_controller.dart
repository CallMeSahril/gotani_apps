import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/model/model_product.dart';
import '../../dashboard/model/model_transaction.dart';

class DetailTransactionController extends GetxController {
  //TODO: Implement DetailTransactionController
  RxList<ModelProduct> product = <ModelProduct>[].obs;
  Rx<ModelTransaction> transaction = ModelTransaction().obs;

  transactionDone() async {
    final token = await TokenManager().getToken();
    final response = await http.post(
      Uri.parse("$mainUrl/transaction/${transaction.value.id}/complete"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    var body = jsonDecode(response.body);
    if (body['status'] == "success" && response.statusCode == 200) {
      Get.offAllNamed(Routes.DASHBOARD);
      Get.snackbar("Info", "Transaksi berhasil diselesaikan");
    } else {
      Get.snackbar("Info", "Gagal Melakukan Transaksi.");
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    transaction.value = Get.arguments[0];
    product.value = Get.arguments[1];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
