import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/product.service.dart';
import 'package:gotani_apps/app/modules/admin_product/product/controllers/product_controller.dart';
import 'package:image_picker/image_picker.dart';

class FormProductController extends GetxController {
  final TextEditingController namaBarang = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController stok = TextEditingController();

  final ProductService productService = ProductService();

  final ImagePicker picker = ImagePicker();

  bool isLoading = false;

  File? imageFile;
  XFile? image;
  String? imagePath;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      final product = arguments['product'];
      if (product != null) {
        namaBarang.text = product['name'];
        harga.text = product['price'].toString();
        category.text = product['category_id'].toString();
        deskripsi.text = product['description'];
        stok.text = product['stock'].toString();
        imagePath = product['image_url'];
      }
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);

      File compressedImage = await compressImage(imageFile!);
      imageFile = compressedImage;

      imagePath = compressedImage.path;
      update();
    } else {
      print('No image selected.');
    }
  }

  Future<File> compressImage(File file) async {
    Uint8List imageBytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image != null) {
      img.Image resizedImage = img.copyResize(image, width: 600);

      Uint8List compressedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 80));

      File compressedFile = File('${file.parent.path}/compressed_${file.path.split('/').last}');
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } else {
      return file;
    }
  }

  Future<void> submitProduct() async {
    isLoading = true;
    update();

    try {
      print('Submitting product:');
      print(category.text);
      print(namaBarang.text);
      print(stok.text);
      print(deskripsi.text);
      print(imagePath);
      print(harga.text);

      var response = await productService.postProduct(
        productCategoryId: int.parse(category.text),
        name: namaBarang.text,
        stock: int.parse(stok.text),
        description: deskripsi.text,
        imagePath: imagePath!,
        price: int.parse(harga.text),
      );

      if (response[0] == 'berhasil') {
        Get.back();
        Get.snackbar('Success', 'Product uploaded successfully');

        final productController = Get.find<ProductController>();
        productController.fetchAllProductsAdmin();
      } else {
        Get.snackbar('Error', 'Failed to upload product');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('Error during product upload: $e');
    } finally {
      isLoading = false;
      update();
    }
  }
}
