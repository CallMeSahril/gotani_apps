import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_success_controller.dart';

class TransactionSuccessView extends GetView<TransactionSuccessController> {
  const TransactionSuccessView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Transaction Success',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
