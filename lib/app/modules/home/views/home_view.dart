import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/constants/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          controller.fetchProfile();
          controller.getSellerAnalitics();
          return Future.value(true);
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: Get.width,
                    height: Get.height * 20 / 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hai admin Gotani, layanan terbaik untuk hasil yang lebih baik',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * 10 / 100,
                        ),
                        Container(
                          width: Get.width * 92 / 100,
                          height: 102,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 25, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: AppColors.primary,
                                      size: 9,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Go Tani',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Obx(() => CachedNetworkImage(
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          imageUrl: controller.dataProfile.value
                                                  .storeLogo ??
                                              'https://images.unsplash.com/photo-1587691592099-24045742c181?q=80&w=1173&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )),
                                  ),
                                  title: Text(
                                    'Hi',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  subtitle: Text(
                                    controller.dataProfile.value.storeName ??
                                        'Gotani',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('No. Admin'),
                                      Text('1234678901212'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height * 23 / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Penjualan',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Obx(() => Text(
                                          'Rp. ${controller.sellerAnaliticsData.value.data?.totalTransaksi.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') ?? 0}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Jumlah Produk',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Obx(() => Text(
                                          '${controller.sellerAnaliticsData.value.data?.totalProduk ?? 0}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pesanan Baru',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Obx(() => Text(
                                          '${controller.sellerAnaliticsData.value.data?.transaksiBaru ?? 0}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Laporan Bulanan',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                DataTable(
                                  columns: [
                                    DataColumn(label: Text('Kategori')),
                                    DataColumn(label: Text('Jumlah')),
                                    DataColumn(label: Text('Pendapatan')),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text('Bibit')),
                                      DataCell(Text('50')),
                                      DataCell(Text('Rp. 5.000.000')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('Pupuk')),
                                      DataCell(Text('30')),
                                      DataCell(Text('Rp. 3.000.000')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('Racun')),
                                      DataCell(Text('20')),
                                      DataCell(Text('Rp. 2.000.000')),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text('Alat Tani')),
                                      DataCell(Text('10')),
                                      DataCell(Text('Rp. 1.000.000')),
                                    ]),
                                  ],
                                ),
                              ],
                            ),
                            // child: Column(
                            //   crossAxisAlignment: CrossAxisAlignment.stretch,
                            //   children: [
                            //     Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Text(
                            //           'Analytics',
                            //           style: TextStyle(
                            //             fontSize: 18,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //         Container(
                            //           padding: EdgeInsets.symmetric(
                            //               horizontal: 12, vertical: 6),
                            //           decoration: BoxDecoration(
                            //             border: Border.all(color: Colors.grey),
                            //             borderRadius: BorderRadius.circular(20),
                            //           ),
                            //           child: Row(
                            //             children: [
                            //               Text('This Week'),
                            //               Icon(Icons.arrow_drop_down),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     SizedBox(height: 20),
                            //     // Bar Chart
                            //     SizedBox(
                            //       height: 210.px,
                            //       child: Obx(() => Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceEvenly,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.end,
                            //             children: controller.analytics.entries
                            //                 .map((entry) {
                            //               return Column(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.end,
                            //                 children: [
                            //                   Text('${entry.value.toInt()}%'),
                            //                   Container(
                            //                     width: 40,
                            //                     height: entry.value * 2,
                            //                     color: Colors.blue,
                            //                     margin: EdgeInsets.symmetric(
                            //                         horizontal: 8),
                            //                   ),
                            //                   SizedBox(height: 8),
                            //                   Text(entry.key),
                            //                 ],
                            //               );
                            //             }).toList(),
                            //           )),
                            //     ),
                            //   ],
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
