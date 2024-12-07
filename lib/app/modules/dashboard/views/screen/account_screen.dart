import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/account_controller.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchProfile();
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.role.value == "user"
                ? Column(
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            controller.dataProfile.value.storeLogo == null
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[300],
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  )
                                : Image.network(
                                    controller.dataProfile.value.storeLogo!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                            const SizedBox(width: 16),
                            Text(
                              controller.name.value,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        height: 30,
                        thickness: 1,
                      ),
                      Obx(
                        () => _buildAccountInfoItem(
                          'Email',
                          controller.profile.value.email ?? "-",
                        ),
                      ),
                      Obx(
                        () => _buildAccountInfoItem(
                          'Nama lengkap',
                          controller.profile.value.name ?? "-",
                        ),
                      ),
                      InkWell(
                        onTap: controller.logout,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Keluar",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Row(
                        children: [
                          controller.dataProfile.value.storeLogo == null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[300],
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: NetworkImage(controller
                                          .dataProfile.value.storeLogo!),
                                      fit: BoxFit.cover,
                                    ),
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
                          'Email',
                          controller.profile.value.email ?? "-",
                        ),
                      ),
                      Obx(
                        () => _buildAccountInfoItem(
                          'Nama lengkap',
                          controller.profile.value.name ?? "-",
                        ),
                      ),
                      Obx(
                        () => _buildAccountInfoItem(
                          'Nama Toko',
                          controller.profile.value.storeName ?? "-",
                        ),
                      ),
                      Obx(
                        () => _buildAccountInfoItem(
                          'Alamat Toko',
                          controller.profile.value.storeAddress ?? "-",
                        ),
                      ),
                      Obx(
                        () => _buildAccountInfoItem(
                          'Provinsi',
                          controller.profile.value.storeProvince ?? "-",
                        ),
                      ),
                      Obx(
                        () => _buildAccountInfoItem(
                          'Kabupaten',
                          controller.profile.value.storeCity ?? "-",
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.EDIT_ACCOUNT, arguments: [
                            controller.profile,
                            controller.province,
                            controller.kabupaten
                          ]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF439A31),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Edit",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: controller.logout,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Keluar",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ],
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
