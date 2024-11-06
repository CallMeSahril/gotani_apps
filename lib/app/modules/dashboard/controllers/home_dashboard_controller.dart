import 'package:get/get.dart';
import 'package:gotani_apps/app/core/assets/assets.gen.dart';

class HomeDashboardController extends GetxController {
  RxList<Map<String, dynamic>> listCategori = [
    {
      "icon": 'assets/images/bibit.png',
      "name": "Bibit",
    },
    {
      "icon": 'assets/images/pupuk.png',
      "name": "Pupuk",
    },
    {
      "icon": 'assets/images/racun.png',
      "name": "Racun",
    },
    {
      "icon": 'assets/images/alat_tani.png',
      "name": "Alat Tani",
    }
  ].obs;
  @override
  void onInit() {
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
}
