import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../../main.dart';
import '../../../../core/helper/shared_preferences_helper.dart';

class CategoryFormController extends GetxController {
  final nameController = TextEditingController();
  final stockController = TextEditingController();
  RxString selectedImage = 'Choose File'.obs;
  XFile? image;

  Future<void> saveCategory() async {
    final token = await TokenManager().getToken();
    final url = Uri.parse("$mainUrl/product-categories");

    try {
      var request = http.MultipartRequest('POST', url);

      request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

      request.fields['name'] = nameController.text;
      request.fields['description'] = stockController.text;

      if (image != null) {
        var imageFile = await http.MultipartFile.fromPath(
          'image',
          image!.path,
        );
        request.files.add(imageFile);
      }

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      var body = jsonDecode(responseBody.body);

      if (body['status'] == "success") {
        Get.back();
        Get.snackbar("Info", "Berhasil menambahkan kategori.");
      } else {
        Get.snackbar("Info", "Gagal menambahkan kategori.");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Terjadi kesalahan saat menyimpan kategori.");
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = pickedFile;
      selectedImage.value = pickedFile.path;
    } else {
      print('No image selected.');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    stockController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      nameController.text = arguments['name'] ?? '';
      stockController.text = arguments['stock']?.toString() ?? '';
      selectedImage.value = arguments['image'] ?? 'Choose File';
    }
  }
}
