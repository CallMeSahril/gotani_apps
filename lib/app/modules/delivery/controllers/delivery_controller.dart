import 'package:get/get.dart';

import '../../dashboard/model/model_delivery_type.dart';

class DeliveryController extends GetxController {
  //TODO: Implement DeliveryController
  RxInt origin = 0.obs, destination = 0.obs, weight = 0.obs;
  RxString courier = "".obs;
  RxList<String> listCourier = <String>["jne", "pos", "tiki"].obs;
  var listDeliveryType = [].obs;

  void fetchDeliveryType() {
    courier.refresh();
    origin.refresh();
    destination.refresh();
    weight.refresh();
    ModelDeliveryType.fetchDeliveryType(
      courier: courier.value,
      origin: origin.value,
      destination: destination.value,
      weight: weight.value,
    );
  }

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
    courier = "".obs;
    origin = 0.obs;
    destination = 0.obs;
    weight = 0.obs;
    courier.refresh();
    origin.refresh();
    destination.refresh();
    weight.refresh();
  }
}
