import 'package:get/get.dart';
import 'package:gotani_apps/app/core/assets/assets.gen.dart';

class HomeDashboardController extends GetxController {
  RxList listCategori = [
    {
      "icon": Assets.images.logo.path,
      "name": "Bibit",
    },
    {
      "icon": "icon",
      "name": "Pupuk",
    },
    {
      "icon": "icon",
      "name": "Racun",
    },
    {
      "icon": "icon",
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
