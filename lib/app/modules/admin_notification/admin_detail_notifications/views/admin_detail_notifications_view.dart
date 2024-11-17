import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/admin_notification/admin_detail_notifications/controllers/admin_detail_notifications_controller.dart';
import 'package:intl/intl.dart';

class AdminDetailNotificationsView
    extends GetView<AdminDetailNotificationsController> {
  const AdminDetailNotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  SizedBox(height: 16),
                  _buildItemList(),
                  SizedBox(height: 16),
                  _buildTotalPrice(),
                  SizedBox(height: 24),
                  _buildActionButtons(),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
                'Nomor Pesanan', controller.notification['id'].toString()),
            _buildInfoRow(
                'Tgl Pesanan',
                DateFormat('dd/MM/yyyy').format(DateTime.parse(
                    controller.notification['date']?.toString() ?? ''))),
            _buildInfoRow('Nama Pengguna',
                controller.notification['userName']?.toString() ?? ''),
            _buildInfoRow('Alamat Pengiriman',
                controller.notification['address']?.toString() ?? ''),
            _buildInfoRow(
                'Telepon', controller.notification['phone']?.toString() ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$label : ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildItemList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Item',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  children: [
                    Text('Nama Produk',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Jumlah',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Harga',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                ...(controller.notification['items'] as List<dynamic>)
                    .map((item) => TableRow(
                          children: [
                            Text(item['name']),
                            Text(item['quantity'].toString()),
                            Text(
                                'Rp. ${NumberFormat('#,###').format(item['price'])}'),
                          ],
                        )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Harga :',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp. ${NumberFormat('#,###').format(controller.totalPrice)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.processOrder,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text('Diproses'),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: controller.cancelOrder,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text('Batalkan Pesanan'),
          ),
        ),
      ],
    );
  }
}
