import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotani_apps/app/core/services/product.service.dart';
import 'package:gotani_apps/app/modules/admin_notification/admin_detail_notifications/controllers/admin_detail_notifications_controller.dart';
import 'package:gotani_apps/app/modules/admin_product/product/controllers/product_controller.dart';
import 'package:gotani_apps/app/modules/edit_produk/controllers/edit_produk_controller.dart';
import 'package:image_picker/image_picker.dart';

class FormProductController extends GetxController {
  final TextEditingController namaBarang = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController stok = TextEditingController();
  final TextEditingController weight = TextEditingController();

  final ProductService productService = ProductService();
  final dataDetail = Rx<dynamic>(null);

  final ImagePicker picker = ImagePicker();
  Rx<int> selectedCategory = 1.obs;
  bool isLoading = false;
  var isLoadingfetchDataTransactionDetail = false.obs;

  File? imageFile;
  XFile? image;
  String? imagePath;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null) {
      final product = arguments['product_id'];
      if (product != null) {
        fetchDataTransactionDetail("$product");
      }
    }
  }

  Future fetchDataTransactionDetail(String isId) async {
    isLoadingfetchDataTransactionDetail.value = true;
    ProductService().getProduct(int.parse(isId)).then((product) {
      if (product != null) {
        namaBarang.text = product.data?.name ?? '';
        harga.text = product.data!.price.toString();
        deskripsi.text = product.data!.description.toString();
        stok.text = product.data!.stock.toString();
        weight.text = product.data!.weight.toString();
        selectedCategory.value = product.data?.productCategoryId ?? 0;
        imagePath = product.data?.imageUrl;
        update();
      }
    });
    // final response = await RepoDetailTransaction()
    //     .getTransactionDetailPacked(isId == ' ' ? '1' : isId);
    // if (response != null) {
    //   dataDetail.value = response.data;
    // }
    isLoadingfetchDataTransactionDetail.value = false;
  }

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
    isLoading = true;
    print('submit');
    update();
    try {
      print(selectedCategory.value);
      print(namaBarang.text);
      print(stok.text);
      print(deskripsi.text);
      print(imagePath);
      print(harga.text);
      print(weight.text);
      var response = await productService.postProduct(
        context: Get.context!,
        productCategoryId: selectedCategory.value,
        name: namaBarang.text,
        stock: int.parse(stok.text),
        description: deskripsi.text,
        imagePath: imagePath!,
        price: int.parse(harga.text),
        weight: int.parse(weight.text),
      );
      if (response[0] == 'berhasil') {
        Get.back();
        Get.snackbar('Success', 'Product uploaded successfully');
        final controller = Get.find<ProductController>();

        controller.fetchAllProductsAdmin();
      } else {
        Get.snackbar('Error', 'Failed to upload product');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> editProduct(String id) async {
    isLoading = true;
    update();
    try {
      var response = await productService.putProduct(
        id: id,
        context: Get.context!,
        productCategoryId: selectedCategory.value,
        name: namaBarang.text,
        stock: int.parse(stok.text),
        description: deskripsi.text,
        // imagePath: imagePath!,
        price: int.parse(harga.text),
        weight: int.parse(weight.text),
      );
      if (response[0] == 'berhasil') {
        Get.back();
        Get.back();
        Get.snackbar('Success', 'Product uploaded successfully');
        final controller = Get.find<ProductController>();
        controller.fetchAllProductsAdmin();
      } else {
        Get.snackbar('Error', 'Failed to upload product');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }
}
