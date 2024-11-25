import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/category.service.dart';
import 'package:gotani_apps/app/modules/admin_category/category_list/controllers/category_list_controller.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class CategoryFormController extends GetxController {
  final nameController = TextEditingController();
  final stockController = TextEditingController();

  final categoryService = CategoryService();

  final ImagePicker picker = ImagePicker();

  bool isLoading = false;

  File? imageFile;

  String? imagePath;

  ValueNotifier<double> compressionProgress = ValueNotifier<double>(0.0);

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      final product = arguments['category'];
      if (product != null) {
        nameController.text = product['name'];
        stockController.text = product['price'].toString();
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

      compressionProgress.value = 0.01;

      Uint8List compressedBytes = Uint8List.fromList(img.encodeJpg(resizedImage, quality: 80));

      compressionProgress.value = 1.0;

      File compressedFile = File('${file.parent.path}/compressed_${file.path.split('/').last}');
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } else {
      return file;
    }
  }

  Future<void> submitCategory() async {
    isLoading = true;
    update();

    try {
      print('Submitting category:');
      print(nameController.text);
      print(stockController.text);
      print(imagePath);
      var response = await categoryService.postCategory(
        name: nameController.text,
        stock: int.parse(stockController.text),
        imagePath: imagePath!,
      );

      if (response[0] == 'berhasil') {
        Get.back();
        Get.snackbar('Success', 'Category uploaded successfully');

        // final categoryController = Get.find<CategoryListController>();
        // categoryController.getAllCategories();
      } else {
        Get.snackbar('Error', 'Failed to upload category');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('Error during category upload: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    stockController.dispose();
    super.onClose();
  }
}
