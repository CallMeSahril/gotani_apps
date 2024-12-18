import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/components/formatter_price.dart';
import '../controllers/detail_transaction_controller.dart';

class DetailTransactionView extends GetView<DetailTransactionController> {
  const DetailTransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${controller.transaction.value.orderId}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.product.length,
              itemBuilder: (context, index) {
                var product = controller.product[index];
                var productTransaction =
                    controller.transaction.value.transactionItems![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 10.h,
                      child: Image.network(
                        product.imageUrl ?? "",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      'Nama Barang: ${product.name}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Harga: ${Formatter.formatToRupiah(product.price)}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Jumlah: ${productTransaction.quantity}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Text(
              'Total: ${Formatter.formatToRupiah(controller.transaction.value.total)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Tanggal Beli: ${Formatter.formatDate(controller.transaction.value.createdAt ?? DateTime.now())}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            controller.transaction.value.status == 'delivered'
                ? ElevatedButton(
                    onPressed: () {
                      controller.transactionDone();
                    },
                    child: Text("Pesanan Diterima"))
                : Text(
                    'Status: ${controller.transaction.value.status}',
                    style: TextStyle(fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }
}
