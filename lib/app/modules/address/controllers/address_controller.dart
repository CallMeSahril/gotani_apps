import 'package:get/get.dart';

import '../../dashboard/model/model_address.dart';
import '../../dashboard/model/model_kabupaten.dart';
import '../../dashboard/model/model_province.dart';

class AddressController extends GetxController {
  //TODO: Implement AddressController
  RxList<ModelAddress> listAddress = <ModelAddress>[].obs;
  RxList<ModelProvince> listProvinsi = <ModelProvince>[].obs;
  RxList<ModelKabupaten> listKabupaten = <ModelKabupaten>[].obs;
  Rx<ModelProvince> provinsi = ModelProvince().obs;
  Rx<ModelKabupaten> kabupaten = ModelKabupaten().obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchAddress();
    fetchProvince();
  }

  @override
  void onClose() {
    super.onClose();
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

  Future<void> fetchAddress() async {
    await ModelAddress.fetchAddress().then((value) {
      listAddress.value = value;
      listAddress.refresh();
    });
  }
}
