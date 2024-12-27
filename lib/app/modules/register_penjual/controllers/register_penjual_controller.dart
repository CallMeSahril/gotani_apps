import 'dart:io';

import 'package:get/get.dart';
import 'package:gotani_apps/app/controllers/auth_controller.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPenjualController extends GetxController {
  //TODO: Implement RegisterPenjualController
  final AuthController authController = Get.put(AuthController());
  final count = 0.obs;
  Rxn<File> isImage = Rxn<File>();
  var isEyes = true.obs;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      isImage.value = File(pickedFile.path);
    }
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

  void increment() => count.value++;
}
