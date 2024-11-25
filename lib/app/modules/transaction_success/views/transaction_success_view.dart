import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/transaction_success_controller.dart';

class TransactionSuccessView extends GetView<TransactionSuccessController> {
  const TransactionSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: width * 0.8,
              child: Image.asset(
                "assets/images/transaction_success.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              'Transaction Success',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: width * 0.5,
              child: ElevatedButton(
                onPressed: () async {
                  Get.offAllNamed(Routes.DASHBOARD);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
