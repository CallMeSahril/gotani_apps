import 'package:get/get.dart';

class AccountController extends GetxController {
  // Sample data, replace with actual data fetching logic
  var name = 'Annisa'.obs;
  var email = '@gmail.com'.obs;
  var phoneStatus = 'Belum Verifikasi'.obs;
  var genderStatus = 'Belum Verifikasi'.obs;
  var birthDateStatus = 'Belum Verifikasi'.obs;

  void fetchData() {
    // Logic to fetch data from API or local storage can go here
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
  }
}
