import 'package:get/get.dart';
import 'package:gotani_apps/app/data/repo/request_seller_repository.dart';

class RequestSellerController extends GetxController {
  RequestSellerRepository requestSellerRepository = RequestSellerRepository();

  Future<void> requestSeller(RequestSellerModel data) async {
    await requestSellerRepository.createRequest(data);
  }
}
