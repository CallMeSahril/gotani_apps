import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../../main.dart';
import '../../../../core/helper/shared_preferences_helper.dart';
import '../../../../routes/app_pages.dart';
import '../../../dashboard/model/model_product.dart';
import '../../../dashboard/model/model_transaction.dart';

class AdminDetailNotificationsController extends GetxController {
  RxList<ModelProduct> product = <ModelProduct>[].obs;
  Rx<ModelTransaction> transaction = ModelTransaction().obs;

  void processOrder() {
    transactionDone() async {
      final token = await TokenManager().getToken();
      final response = await http.post(
        Uri.parse("$mainUrl/transaction/${transaction.value.id}/complete"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.DASHBOARD);
        Get.snackbar('Success', 'Order is being processed');
      } else {
        Get.snackbar("Info", "Gagal Melakukan Transaksi.");
      }
    }
  }

  void cancelOrder() {
    Get.snackbar('Cancelled', 'Order has been cancelled');
  }

  @override
  void onInit() {
    super.onInit();
    transaction.value = Get.arguments[0];
    product.value = Get.arguments[1];
  }
}
