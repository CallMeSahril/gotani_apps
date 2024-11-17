import 'package:get/get.dart';

import '../model/model_transaction.dart';

class NotificationController extends GetxController {
  RxList<ModelTransaction> transaction = <ModelTransaction>[].obs;

  Future<void> fetchTransaction() async {
    await ModelTransaction.fetchTransactions().then((value) {
      transaction.value = value;
      transaction.refresh();
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchTransaction();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
