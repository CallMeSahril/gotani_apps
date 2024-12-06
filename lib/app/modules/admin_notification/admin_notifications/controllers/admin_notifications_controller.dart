import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../dashboard/model/model_product.dart';
import '../../../dashboard/model/model_transaction.dart';

class AdminNotificationsController extends GetxController {
  RxList<ModelTransaction> transaction = <ModelTransaction>[].obs;

  Future<void> fetchTransaction() async {
    await ModelTransaction.fetchTransactions().then((value) {
      transaction.value = value;
      transaction.refresh();
    });
  }

  toDetailTransaction(index) async {
    var transactions = transaction[index];
    List<ModelProduct> listProduct = [];
    if (transactions.transactionItems != null) {
      for (var product in transactions.transactionItems!) {
        ModelProduct data = await ModelProduct.fetchDetailsRecords(
            id: product.productId.toString());
        listProduct.add(data);
      }
    }
    Get.toNamed(Routes.ADMIN_DETAIL_NOTIFICATIONS,
        arguments: [transaction, listProduct]);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchTransaction();
  }
}

// Model
class Notification {
  final String date;
  final String username;
  final String status;

  Notification({
    required this.date,
    required this.username,
    required this.status,
  });
}
