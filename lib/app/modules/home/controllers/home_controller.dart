import 'package:get/get.dart';
import 'package:gotani_apps/app/modules/dashboard/model/model_profile.dart';

class HomeController extends GetxController {
  final totalSales = 10000000.obs;
  final productCount = 100.obs;
  final newOrders = 20.obs;

  final analytics = {
    'Bibit': 65.0,
    'Pupuk': 80.0,
    'Racun': 50.0,
  }.obs;
  Rx<ModelProfile> dataProfile = ModelProfile().obs;

  fetchProfile() async {
    await ModelProfile.fetchProfile().then((value) {
      dataProfile.value = value;
    });
  }

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }
}
