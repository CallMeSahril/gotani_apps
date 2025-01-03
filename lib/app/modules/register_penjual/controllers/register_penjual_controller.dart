import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/controllers/auth_controller.dart';
import 'package:gotani_apps/app/data/repo/auth/auth_repo.dart';
import 'package:gotani_apps/app/modules/dashboard/model/model_kabupaten.dart';
import 'package:gotani_apps/app/modules/dashboard/model/model_province.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPenjualController extends GetxController {
  //TODO: Implement RegisterPenjualController
  final AuthController authController = Get.put(AuthController());
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();
  final TextEditingController controllerNamaToko = TextEditingController();
  final TextEditingController controllerAlamatToko = TextEditingController();
  RxList<ModelProvince> listProvinsi = <ModelProvince>[].obs;
  RxList<ModelKabupaten> listKabupaten = <ModelKabupaten>[].obs;
  var provinsiToko = 1.obs;
  var kotaToko = 1.obs;
  final count = 0.obs;
  Rx<ModelProvince> province = ModelProvince().obs;
  Rx<ModelKabupaten> kabupaten = ModelKabupaten().obs;
  Rxn<File> isImage = Rxn<File>();
  var isEyes = true.obs;
  var isLoading = false.obs;

  Future<void> fetchKabupaten(String idProv) async {
    isLoading.value = true;
    await ModelKabupaten.fetchKabupaten(idProv).then((value) {
      listKabupaten.value = value;
      listKabupaten.refresh();
    });
    isLoading.value = false;
  }

  Future<void> fetchProvince() async {
    await ModelProvince.fetchProvince().then((value) {
      listProvinsi.value = value;
      listProvinsi.refresh();
    });
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isImage.value = File(pickedFile.path);
    }
  }

  void isregister() {
    final userData = UploadUser(
      name: controllerName.text,
      email: controllerEmail.text,
      password: controllerPass.text,
      storeName: controllerNamaToko.text,
      storeAddress: controllerAlamatToko.text,
      storeProvince: province.value.province,
      storeProvinceId: province.value.provinceId,
      storeCity: kabupaten.value.cityName,
      storeCityId: kabupaten.value.cityId,
      storeLogoUpload: isImage.value,
    );
    authController.register(userData);
  }

  @override
  void onInit() {
    fetchProvince();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
