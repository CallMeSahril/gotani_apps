import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/controllers/transaksi_controller.dart';
import '../controllers/history_penjual_controller.dart';

class HistoryPenjualView extends GetView<HistoryPenjualController> {
  const HistoryPenjualView({super.key});

  @override
  Widget build(BuildContext context) {
    // Pastikan TransaksiController diinisialisasi sebelum digunakan
    final transaksiController = Get.put(TransaksiController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('History Penjual'),
        centerTitle: true,
      ),
      body: GetBuilder<TransaksiController>(
        initState: (_) {
          transaksiController.getHistory();
        },
        builder: (_) {
          return _.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            value: _.selectedFilter,
                            items: _.filterList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              _.updateSelectedFilter(newValue!);
                              transaksiController.filterHistory(newValue);
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              transaksiController.clearFilter();
                            },
                            child: const Text('Clear Filter'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _.dataTransaksi.length,
                        itemBuilder: (context, index) {
                          final result = _.dataTransaksi[index];
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(result.customer?.name ??
                                        'Nama Tidak Ada'),
                                    Text(result.status ?? 'Status Tidak Ada'),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: result.transactionItems?.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        result.transactionItems![index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.network(
                                            item.product?.imageUrl ?? '',
                                            width: 50,
                                            height: 50),
                                        Column(
                                          children: [
                                            Text(item.product?.name ??
                                                'Nama Produk Tidak Ada'),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(item.quantity.toString() ??
                                                    'Qty Tidak Ada'),
                                                Text("x"),
                                                Text(item.product?.price
                                                        .toString() ??
                                                    'Harga Tidak Ada'),
                                                Text("="),
                                                Text(item?.price.toString() ??
                                                    'Total Tidak Ada'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
