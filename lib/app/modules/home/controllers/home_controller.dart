import 'package:get/get.dart';
import 'package:gotani_apps/app/controllers/laporan_controller.dart';
import 'package:gotani_apps/app/data/repo/laporan/laporan_repo.dart';
import 'package:gotani_apps/app/modules/dashboard/model/model_profile.dart';
import 'package:gotani_apps/app/modules/home/repository/repositority_home.dart';

class HomeController extends GetxController {
  final totalSales = 10000000.obs;
  final productCount = 100.obs;
  final newOrders = 20.obs;
  var isloading = false.obs;
  var sellerAnaliticsData = SellerAnaliticsModel().obs;
  var getAnaliticsCatagory = GetAnaliticsCatagory().obs;
  final LaporanController laporanController = Get.put(LaporanController());
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

  Future<void> getSellerAnalitics() async {
    final respone = await RepositorityHome().getSellerAnalitics();
    if (respone.status == "success") {
      sellerAnaliticsData.value = respone;
    }
  }

  Future<void> getLaporan() async {
    isloading.value = true;
    final respone = await laporanController.getAnaliticsCatagory();
    getAnaliticsCatagory.value = respone;
    isloading.value = false;
  }

  @override
  void onInit() {
    getLaporan();
    fetchProfile();
    getSellerAnalitics();
    super.onInit();
  }
}
