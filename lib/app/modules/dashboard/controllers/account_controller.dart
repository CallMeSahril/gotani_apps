import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

import '../../../core/helper/shared_preferences_helper.dart';
import '../../../routes/app_pages.dart';
import '../model/model_kabupaten.dart';
import '../model/model_profile.dart';
import '../model/model_province.dart';

class AccountController extends GetxController {
  // Sample data, replace with actual data fetching logic
  var name = 'Annisa'.obs;
  var email = '@gmail.com'.obs;
  var phoneStatus = 'Belum Verifikasi'.obs;
  var genderStatus = 'Belum Verifikasi'.obs;
  var birthDateStatus = 'Belum Verifikasi'.obs;
  Rx<ModelProfile> profile = ModelProfile().obs;
  Rx<ModelProvince> province = ModelProvince().obs;
  Rx<ModelKabupaten> kabupaten = ModelKabupaten().obs;
  Rx<ModelProfile> dataProfile = ModelProfile().obs;
  RxString role = "".obs;

  fetchProfile() async {
    await ModelProfile.fetchProfile().then((value) {
      dataProfile.value = value;
      profile.value = value;
      profile.refresh();
      province.value.province = value.storeProvince;
      province.value.provinceId = value.storeProvinceId;
      kabupaten.value.cityName = value.storeCity;
      kabupaten.value.cityId = value.storeCityId;
    });
  }

  getRole() async {
    role.value = await RoleManager().getRole() ?? "";
  }

  logout() async {
    await TokenManager().logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
