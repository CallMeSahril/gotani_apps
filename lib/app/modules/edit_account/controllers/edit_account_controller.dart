import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';
import '../../../routes/app_pages.dart';
import '../../dashboard/model/model_kabupaten.dart';
import '../../dashboard/model/model_profile.dart';
import '../../dashboard/model/model_province.dart';

class EditAccountController extends GetxController {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerStoreName = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  Rx<ModelProfile> profile = ModelProfile().obs;
  RxList<ModelProvince> listProvinsi = <ModelProvince>[].obs;
  RxList<ModelKabupaten> listKabupaten = <ModelKabupaten>[].obs;
  Rx<ModelProvince> province = ModelProvince().obs;
  Rx<ModelKabupaten> kabupaten = ModelKabupaten().obs;
  //TODO: Implement EditAccountController

  fetchProfile() {
    ModelProfile.fetchProfile().then((value) {
      profile.value = value;
      profile.refresh();
      province.value.province = value.storeProvince;
      province.value.provinceId = value.storeProvinceId;
      kabupaten.value.cityName = value.storeCity;
      kabupaten.value.cityId = value.storeCityId;
    });
  }

  updateProfile() async {
    if (controllerName.text.isEmpty ||
        controllerAddress.text.isEmpty ||
        province.value.province == null ||
        kabupaten.value.cityName == null) {
      Get.snackbar("Warning", "Mohon isi seluruh kolom.");
      return;
    }
    final token = await TokenManager().getToken();

    final response = await http.put(
      Uri.parse("$mainUrl/profile"),
      body: {
        "name": controllerName.text,
        "store_name": controllerStoreName.text,
        "address": controllerAddress.text,
        "province": province.value.province,
        "province_id": province.value.provinceId,
        "city": kabupaten.value.cityName,
        "city_id": kabupaten.value.cityId,
      },
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    var body = jsonDecode(response.body);
    print(body['status'] == "success");
    if (body['status'] == "success") {
      Get.offAllNamed(Routes.DASHBOARDPENJUAL);
    }
  }

  Future<void> fetchKabupaten(String idProv) async {
    await ModelKabupaten.fetchKabupaten(idProv).then((value) {
      listKabupaten.value = value;
      listKabupaten.refresh();
    });
  }

  Future<void> fetchProvince() async {
    await ModelProvince.fetchProvince().then((value) {
      listProvinsi.value = value;
      listProvinsi.refresh();
    });
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    profile = Get.arguments[0];
    province = Get.arguments[1];
    kabupaten = Get.arguments[2];
    fetchProvince();
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
