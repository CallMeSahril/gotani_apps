import 'package:get/get.dart';

import '../model/model_transaction.dart';

class NotificationController extends GetxController {
  RxList<ModelTransaction> transaction = <ModelTransaction>[].obs;
  var isLoading = false.obs;
  Future<void> fetchTransaction(bool isFlitered) async {
    isLoading.value = true;
    final respone = await ModelTransaction.fetchTransactions();

    if (isFlitered) {
      transaction.value = respone;
      transaction.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      transaction.value =
          transaction.where((tx) => tx.status == selectedStatus.value).toList();
    } else {
      transaction.value = respone;
      transaction.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    }
    isLoading.value = false;
  }

  RxString selectedStatus = 'All'.obs;
  List<String> statusList = [
    'All',
    'pending',
    'completed',
    'cancelled',
    'delivered'
  ];

  void filterTransactionByStatus() {
    if (selectedStatus.value == 'All') {
      fetchTransaction(false);
    } else {
      fetchTransaction(true);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    filterTransactionByStatus();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
