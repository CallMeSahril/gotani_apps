import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/product.service.dart';
import 'package:image_picker/image_picker.dart';

class FormProductController extends GetxController {
  final TextEditingController namaBarang = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController stok = TextEditingController();
  final TextEditingController weight = TextEditingController();

  final ProductService productService = ProductService();

  final ImagePicker picker = ImagePicker();

  bool isLoading = false;

  File? imageFile;
  XFile? image;
  String? imagePath;

  // Fungsi untuk memilih gambar
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      image = pickedFile;
      imagePath = pickedFile.path;
      update();
    } else {
      print('No image selected.');
    }
  }

  Future<void> submitProduct() async {
    // isLoading = true;
    // print('submit');
    // update();
    // try {
    //   print(category.text);
    //   print(namaBarang.text);
    //   print(stok.text);
    //   print(deskripsi.text);
    //   print(imagePath);
    //   print(harga.text);
    //   print(weight.text);
    //   var response = await productService.uploadProduct(
    //     productCategoryId: int.parse(category.text),
    //     name: namaBarang.text,
    //     stock: int.parse(stok.text),
    //     description: deskripsi.text,
    //     imagePath: imagePath!,
    //     price: int.parse(harga.text),
    //     weight: int.parse(weight.text),
    //   );
    //   if (response.statusCode == 200) {
    //     Get.snackbar('Success', 'Product uploaded successfully');
    //   } else {
    //     Get.snackbar('Error', 'Failed to upload product');
    //   }
    // } catch (e) {
    //   Get.snackbar('Error', e.toString());
    //   print(e);
    // } finally {
    //   isLoading = false;
    //   update();
    // }
  }
}
