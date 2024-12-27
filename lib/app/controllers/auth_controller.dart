import 'package:get/get.dart';
import 'package:gotani_apps/app/data/repo/auth/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo = AuthRepo();
  var dataUser = <UserModel>[].obs;

  Future<void> register(UploadUser UploadUser) async {
    final resp = await _authRepo.register(UploadUser);
    // if (resp.isEmpty) {
    //   Get.defaultDialog(
    //     title: "Registrasi Gagal",
    //     middleText: "Silakan coba lagi.",
    //     textConfirm: "OK",
    //     onConfirm: () {
    //       Get.back();
    //     },
    //   );
    // } else {
    //   Get.defaultDialog(
    //     title: "Registrasi Berhasil",
    //     middleText: "Silakan coba lagi.",
    //     textConfirm: "OK",
    //     onConfirm: () {
    //       Get.back();
    //     },
    //   );
    // }
  }

//   final count = 0.obs;
//   @override
//   void onInit() {
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   void increment() => count.value++;
}
