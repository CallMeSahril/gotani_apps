import 'package:get/get.dart';

import '../model/model_transaction.dart';

class NotificationController extends GetxController {
  RxList<ModelTransaction> transaction = <ModelTransaction>[].obs;

  Future<void> fetchTransaction() async {
    await ModelTransaction.fetchTransactions().then((value) {
      transaction.value = value;
      transaction.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      transaction.refresh();
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchTransaction();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
