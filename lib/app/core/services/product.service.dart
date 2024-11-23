import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gotani_apps/app/core/services/dio.h.dart';

class ProductService {
  ProductService() {
    configureDioWithToken();
  }

  Future<List> getProduct(int productId) async {
    try {
      final response = await dioCustom.get('products/$productId');

      if (response.statusCode == 200) {
        print(response.data['data']);
        return response.data['data'];
      } else {
        return [];
      }
    } catch (e) {
      print('Error while fetching product: $e');
      return [];
    }
  }

  Future<List<dynamic>> postProduct({
    required BuildContext context,
    required int productCategoryId,
    required String name,
    required int stock,
    required String description,
    required String imagePath,
    required int price,
  }) async {
    try {
      String fileName = imagePath.split('/').last;

      FormData formData = FormData.fromMap({
        'product_category_id': productCategoryId,
        'name': name,
        'stock': stock,
        'description': description,
        'price': price,
        'image': await MultipartFile.fromFile(imagePath, filename: fileName),
      });

      Response response = await dioCustom.post(
        'products',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        return [
          'berhasil'
        ];
      } else {
        return [
          'gagal'
        ];
      }
    } catch (e) {
      print('Error uploading product: $e');
      rethrow;
    }
  }

  // Future<List> postProduct({
  //   required int productCategoryId,
  //   required String name,
  //   required int stock,
  //   required String description,
  //   required String imagePath,
  //   required int price,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     // Konversi imagePath menjadi File
  //     File imageFile = File(imagePath);

  //     // Membuat FormData untuk mengirim data termasuk file
  //     FormData formData = FormData.fromMap({
  //       'product_category_id': productCategoryId.toString(),
  //       'name': name,
  //       'stock': stock.toString(),
  //       'description': description,
  //       'price': price.toString(),
  //       'gambar': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
  //     });

  //     // Melakukan POST request
  //     final response = await dioCustom.post('products', data: formData);

  //     if (response.statusCode == 200) {
  //       if (response.data['message'] != 'success create data') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(response.data['message'].toString())),
  //         );

  //         return [
  //           'error'
  //         ];
  //       } else {
  //         return [
  //           'berhasil'
  //         ];
  //       }
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     print('Error while posting product: $e');
  //     return [];
  //   }
  // }

  Future<List> getAllProducts() async {
    try {
      final response = await dioCustom.get('products');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print('Error while fetching products: $e');
      return [];
    }
  }

  Future<List> getAllProductsAdmin() async {
    try {
      final response = await dioCustom.get('products/get/seller');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data;
      } else {
        return [];
      }
    } catch (e) {
      log('Error while fetching products: $e');
      return [];
    }
  }

  Future<bool> deleteProduct(int productId) async {
    try {
      final response = await dioCustom.delete('products/$productId');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Product deleted successfully');
        return true;
      } else {
        print('Failed to delete product. Status code: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('DioError while deleting product: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
      return false;
    } catch (e) {
      print('Error while deleting product: $e');
      return false;
    }
  }
}
