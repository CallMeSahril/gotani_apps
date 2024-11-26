import 'package:get/get.dart';

import '../../dashboard/model/model_delivery_type.dart';
import '../../dashboard/model/model_product.dart';

class DeliveryController extends GetxController {
  //TODO: Implement DeliveryController
  RxString origin = "0".obs,
      destination = "0".obs,
      weight = "0".obs,
      courier = "".obs;
  RxInt qty = 0.obs;
  Rx<ModelProduct> product = ModelProduct().obs;
  RxList<String> listCourier = <String>["jne", "pos", "tiki"].obs;
  RxList<ModelDeliveryType> listDelivery = <ModelDeliveryType>[].obs;
  var listDeliveryType = [].obs;
  var idProduct = "".obs;

  void fetchproductDetail() {
    ModelProduct.fetchDetailsRecords(id: idProduct.value).then((value) {
      product.value = value;
      origin.value =
          (value.user!.storeCityId == null || value.user!.storeCityId == "")
              ? "501"
              : value.user!.storeCityId.toString();
      weight.value = (value.weight! * qty.value).toString();
    });
  }

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
    ).then((value) {
      listDelivery.value = value;
    });
  }

  @override
  void onInit() {
    super.onInit();
    idProduct.value = Get.arguments[0];
    qty.value = Get.arguments[1];
    destination.value = Get.arguments[2];
    fetchproductDetail();
    print("$origin, $destination, $weight, $courier");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    courier = "".obs;
    origin = "0".obs;
    destination = "0".obs;
    weight = "0".obs;
    courier.refresh();
    origin.refresh();
    destination.refresh();
    weight.refresh();
  }
}
