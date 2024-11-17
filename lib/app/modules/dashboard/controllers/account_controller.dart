import 'package:get/get.dart';

import '../model/model_profile.dart';

class AccountController extends GetxController {
  // Sample data, replace with actual data fetching logic
  var name = 'Annisa'.obs;
  var email = '@gmail.com'.obs;
  var phoneStatus = 'Belum Verifikasi'.obs;
  var genderStatus = 'Belum Verifikasi'.obs;
  var birthDateStatus = 'Belum Verifikasi'.obs;
  var profile = ModelProfile().obs;

  void fetchData() {
    ModelProfile.fetchProfile().then((value) {
      profile.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
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
