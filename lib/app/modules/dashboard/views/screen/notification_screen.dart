import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori Transaksi'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.transaction.length,
          itemBuilder: (context, index) {
            var transaction = controller.transaction[index];
            return Container(
              width: width,
              padding: EdgeInsets.all(width * 0.05),
              margin: EdgeInsets.fromLTRB(
                  width * 0.05, width * 0.05, width * 0.05, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.05),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transaction.orderId ?? "-",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    transaction.status ?? "-",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
