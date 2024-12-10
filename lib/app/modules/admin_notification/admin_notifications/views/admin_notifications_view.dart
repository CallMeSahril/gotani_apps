import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';

import '../controllers/admin_notifications_controller.dart';

class AdminNotificationsView extends GetView<AdminNotificationsController> {
  const AdminNotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notifikasi Pesanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Tanggal',
                            style: TextStyle(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Nama Pengguna',
                            style: TextStyle(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Table Content
                  GetBuilder<AdminNotificationsController>(
                    builder: (controller) {
                      return Column(
                        children: controller.data.map((notification) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.ADMIN_DETAIL_NOTIFICATIONS,
                                  arguments: notification.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[300]!),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      notification.createdAt.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      notification.customer?.name ?? "-",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      notification.status ?? "-",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: notification.status == 'Baru'
                                            ? Colors.blue
                                            : Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lihat Semua Notifikasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
