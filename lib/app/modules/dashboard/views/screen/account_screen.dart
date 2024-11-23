import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/dashboard/controllers/account_controller.dart';

class AccountScreen extends GetView<AccountController> {
  AccountScreen({super.key});
  @override
  final controller = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    controller.fetchProfile();
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF5EC),
        elevation: 0,
        title: Text(
          'Kelola Akun',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<AccountController>(
        init: AccountController(),
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchProfile();
              controller.update();
            },
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[300],
                              child: CachedNetworkImage(
                                imageUrl: controller.user['store_logo'] ?? '',
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              controller.user['name'] ?? 'Unknown',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 30,
                          thickness: 1,
                        ),
                        _buildAccountInfoItem(
                          'Nama lengkap',
                          controller.user['name'] ?? 'Unknown',
                        ),
                        _buildAccountInfoItem(
                          'Tambahkan Nomor',
                          'Tidak ada di response API',
                        ),
                        _buildAccountInfoItem(
                          'Ganti e-mail',
                          controller.user['email'] ?? 'Unknown',
                        ),
                        _buildAccountInfoItem(
                          'Jenis Kelamin',
                          'Tidak ada di response API',
                        ),
                        _buildAccountInfoItem(
                          'Tanggal Lahir',
                          'Tidak ada di response API',
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildAccountInfoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
