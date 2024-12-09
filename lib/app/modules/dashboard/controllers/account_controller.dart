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
  Rx<ModelProfile> profile = ModelProfile().obs;
  Rx<ModelProvince> province = ModelProvince().obs;
  Rx<ModelKabupaten> kabupaten = ModelKabupaten().obs;
  RxString role = "".obs;

  fetchProfile() {
    ModelProfile.fetchProfile().then((value) {
      profile.value = value;
      profile.refresh();
      print("profile sebelum = ${jsonEncode(value)}");
      print("profile = ${jsonEncode(profile.value)}");
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
    final token = await TokenManager().getToken();

    final response = await http.post(
      Uri.parse("$mainUrl/logout"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    var body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      TokenManager().removeToken();
      RoleManager().removeRole();
      Get.offAllNamed(Routes.SPLASHHOME);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    getRole();
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
