import 'package:get/get.dart';
import 'package:gotani_apps/app/core/assets/assets.gen.dart';

import '../model/model_product.dart';

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

  RxList<ModelProduct> listProduct = <ModelProduct>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await ModelProduct.fetchRecords().then((value) {
      listProduct.value = value;
      listProduct.refresh();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
