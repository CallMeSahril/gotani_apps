import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/account_controller.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFEFF5EC), // Warna latar belakang hijau muda
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF5EC),
        elevation: 0,
        title: const Text(
          'Kelola Akun',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Obx(() => Text(
                      controller.name.value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 30,
              thickness: 1,
            ),
            Obx(
              () => _buildAccountInfoItem(
                'Nama lengkap',
                controller.name.value,
              ),
            ),
            Obx(
              () => _buildAccountInfoItem(
                'Tambahkan Nomor',
                controller.phoneStatus.value,
              ),
            ),
            Obx(
              () => _buildAccountInfoItem(
                'Ganti e-mail',
                controller.email.value,
              ),
            ),
            Obx(
              () => _buildAccountInfoItem(
                'Jenis Kelamin',
                controller.genderStatus.value,
              ),
            ),
            Obx(
              () => _buildAccountInfoItem(
                'Tanggal Lahir',
                controller.birthDateStatus.value,
              ),
            ),
          ],
        ),
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
