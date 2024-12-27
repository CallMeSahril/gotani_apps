import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:gotani_apps/app/data/repo/auth/auth_repo.dart';
import 'package:gotani_apps/app/modules/register_penjual/controllers/register_penjual_controller.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/assets/assets.gen.dart';
import 'package:gotani_apps/app/core/components/buttons.dart';
import 'package:gotani_apps/app/core/components/custom_text_field.dart';
import 'package:gotani_apps/app/core/components/spaces.dart';
import 'package:gotani_apps/app/routes/app_pages.dart';
import 'package:gotani_apps/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPenjualView extends GetView<RegisterPenjualController> {
  RegisterPenjualView({super.key});
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  save() async {
    if (_controllerEmail.text == "" ||
        _controllerPass.text == "" ||
        _controllerName.text == "") {
      Get.snackbar("Warning", "Mohon Isi Seluruh Kolom Yang Ada.");
    }
    final response = await http.post(Uri.parse("$mainUrl/register"), body: {
      "name": _controllerName.text,
      "email": _controllerEmail.text,
      "password": _controllerPass.text,
    });
    print(response.body);
    if (response.statusCode == 200) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.snackbar("Warning", "Gagal Mendaftarkan Akun.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            Image.asset(
              Assets.images.logo.path,
              width: 20.w,
              height: 40.h,
            ),
            SpaceHeight(10),
            Text(
              "Daftarkan Akun Anda",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await controller.pickImage();
              },
              child: Obx(
                () => controller.isImage.value == null
                    ? Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey,
                          ),
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                      )
                    : Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: FileImage(controller.isImage.value!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            SpaceHeight(10),
            CustomTextField(
              controller: _controllerName,
              label: "Username",
            ),
            SpaceHeight(10),
            CustomTextField(
              controller: _controllerEmail,
              label: "Email",
            ),
            SpaceHeight(10),
            Obx(() => CustomTextField(
                  controller: _controllerPass,
                  label: "Password",
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isEyes.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      controller.isEyes.value = !controller.isEyes.value;
                    },
                  ),
                )),
            SpaceHeight(10),
            CustomTextField(
              controller: _controllerEmail,
              label: "Nama Toko",
            ),
            SpaceHeight(10),
            CustomTextField(
              controller: _controllerEmail,
              label: "Alamat Toko",
            ),
            SpaceHeight(10),
            CustomTextField(
              controller: _controllerEmail,
              label: "Provinsi Toko",
            ),
            SpaceHeight(10),
            CustomTextField(
              controller: _controllerEmail,
              label: "Kota Toko",
            ),
            SpaceHeight(10),
            CustomTextField(
              controller: TextEditingController(),
              label: "Upload Foto Toko",
              readOnly: true,
              // onTap: () async {
              //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
              //   if (pickedFile != null) {
              //     // Handle the selected image file
              //   }
              // },
              suffixIcon: Icon(Icons.upload_file),
            ),
            SpaceHeight(10),
            Row(
              children: [
                Text(
                  "Register Sebagai Pembeli ? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  child: Text(
                    "Daftarkan Disini",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SpaceHeight(10),
            Button.filled(
              color: Color(0xff00AA13),
              onPressed: () {
                final userData = UploadUser(
                  name: "coba3",
                  email: "coba3gmail.com",
                  password: "tes123",
                  storeName: "seller baru",
                  storeAddress: "jalan seller baru",
                  storeProvince: "Bali",
                  storeProvinceId: '1',
                  storeCity: "Badung",
                  storeCityId: '1',
                  storeLogoUpload: controller.isImage.value,
                );
                controller.authController.register(userData);
              },
              label: "Register",
            ),
            SpaceHeight(10),
            Row(
              children: [
                Text(
                  "Sudah Memiliki akun ? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SpaceHeight(20),
          ]),
        ));
  }
}
