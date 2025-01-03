import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:gotani_apps/app/data/repo/auth/auth_repo.dart';
import 'package:gotani_apps/app/modules/dashboard/model/model_kabupaten.dart';
import 'package:gotani_apps/app/modules/dashboard/model/model_province.dart';
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
            Text("Username"),
            CustomTextField(
              controller: controller.controllerName,
              label: "Username",
            ),
            SpaceHeight(10),
            Text("email"),
            CustomTextField(
              controller: controller.controllerEmail,
              label: "Email",
            ),
            SpaceHeight(10),
            Text("Password"),
            Obx(() => CustomTextField(
                  controller: controller.controllerPass,
                  label: "Password",
                  obscureText: controller.isEyes.value ,
                  suffixIcon: IconButton(
                    icon: Icon(
                      !controller.isEyes.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      controller.isEyes.value = !controller.isEyes.value;
                    },
                  ),
                )),
            SpaceHeight(10),
            Text("Nama Toko"),
            CustomTextField(
              controller: controller.controllerNamaToko,
              label: "Nama Toko",
            ),
            SpaceHeight(10),
            Text('Alamat Toko'),
            CustomTextField(
              controller: controller.controllerAlamatToko,
              label: "Alamat Toko",
            ),
            SpaceHeight(10),
            Text("Provinsi"),
            DropdownSearch<ModelProvince>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
              ),
              selectedItem: controller.province.value.province == null
                  ? ModelProvince(province: "Pilih Provinsi")
                  : controller.province.value,
              items: controller.listProvinsi,
              itemAsString: (item) => item.province!,
              onChanged: (item) {
                controller.province.value = item!;
                controller.fetchKabupaten(item.provinceId!);
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: TextStyle(fontSize: 16),
                dropdownSearchDecoration: InputDecoration(
                  hintText: "Pilih Provinsi",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Kabupaten"),
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : DropdownSearch<ModelKabupaten>(
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      selectedItem: controller.kabupaten.value.cityName == null
                          ? ModelKabupaten(cityName: "Pilih Kabupaten")
                          : controller.kabupaten.value,
                      items: controller.listKabupaten,
                      itemAsString: (item) => item.cityName!,
                      onChanged: (item) {
                        controller.kabupaten.value = item!;
                      },
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        baseStyle: TextStyle(fontSize: 16),
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Pilih Kabupaten",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
            ),
            SpaceHeight(10),
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
                controller.isregister();
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
