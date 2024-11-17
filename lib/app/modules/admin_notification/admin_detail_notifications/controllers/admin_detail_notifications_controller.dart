import 'package:get/get.dart';

class AdminDetailNotificationsController extends GetxController {
  final notification = {
    'id': '#12345',
    'date': DateTime(2024, 10, 4),
    'userName': 'halim123',
    'address': 'Tambon Tunong',
    'phone': '082367895432',
    'items': [
      {'name': 'Pupuk NPK', 'quantity': 5, 'price': 400000},
      {'name': 'Pupuk Urea', 'quantity': 5, 'price': 1350000},
    ]
  }.obs;

  double get totalPrice {
    Object? items = notification['items'];

    if (items != null && items is List<Map<String, dynamic>>) {
      return items.fold(0.0, (sum, item) {
        double quantity = (item['quantity'] ?? 0).toDouble();
        double price = (item['price'] ?? 0).toDouble();

        return sum + (quantity * price);
      });
    }

    return 0.0;
  }

  void processOrder() {
    Get.snackbar('Success', 'Order is being processed');
  }

  void cancelOrder() {
    Get.snackbar('Cancelled', 'Order has been cancelled');
  }
}
