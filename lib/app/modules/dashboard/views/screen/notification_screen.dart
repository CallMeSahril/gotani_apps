import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/formatter_price.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/notification_controller.dart';
import '../../model/model_product.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori Transaksi'),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.fetchTransaction(),
          child: ListView.builder(
            itemCount: controller.transaction.length,
            itemBuilder: (context, index) {
              var transaction = controller.transaction[index];
              return InkWell(
                onTap: () async {
                  List<ModelProduct> listProduct = [];
                  if (transaction.transactionItems != null) {
                    for (var product in transaction.transactionItems!) {
                      ModelProduct data =
                          await ModelProduct.fetchDetailsRecords(
                              id: product.productId.toString());
                      listProduct.add(data);
                    }
                  }
                  Get.toNamed(Routes.DETAIL_TRANSACTION,
                      arguments: [transaction, listProduct]);
                },
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(width * 0.05),
                  margin: EdgeInsets.fromLTRB(
                      width * 0.05, width * 0.05, width * 0.05, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.05),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: width * 0.1,
                            backgroundImage: NetworkImage(
                                transaction.seller!.storeLogo ?? ""),
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.seller!.name ?? "-",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                transaction.seller!.storeAddress ?? "-",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                Formatter.formatToRupiah(
                                  transaction.total,
                                ),
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transaction.orderId ?? "-",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            transaction.status ?? "-",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
