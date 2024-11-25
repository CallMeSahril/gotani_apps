import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:gotani_apps/app/core/services/dio.h.dart';

class CategoryService {
  CategoryService() {
    configureDioWithToken();
  }

  Future<List> getCategory(int categoryId) async {
    try {
      final response = await dioCustom.get('category/$categoryId');

      if (response.statusCode == 200) {
        print(response.data['data']);
        return response.data['data'];
      } else {
        return [];
      }
    } catch (e) {
      print('Error while fetching category: $e');
      return [];
    }
  }

  Future<List<dynamic>> postCategory({
    required String name,
    required int stock,
    required String imagePath,
  }) async {
    try {
      String fileName = imagePath.split('/').last;

      FormData formData = FormData.fromMap({
        'name': name,
        'stock': stock,
        'gambar': await MultipartFile.fromFile(imagePath, filename: fileName),
      });
      log('imagepath : $imagePath, fileName : $fileName');
      Response response = await dioCustom.post(
        'category',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        return [
          'berhasil'
        ];
      } else {
        return [
          'gagal'
        ];
      }
    } catch (e) {
      print('Error uploading category: $e');
      rethrow;
    }
  }

  Future<List> getAllCategoriesAdmin() async {
    try {
      final response = await dioCustom.get('category/get/seller');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data;
      } else {
        return [];
      }
    } catch (e) {
      log('Error while fetching categories: $e');
      return [];
    }
  }

  Future<bool> deleteCategory(int categoryId) async {
    try {
      final response = await dioCustom.delete('category/$categoryId');

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Category deleted successfully');
        return true;
      } else {
        print('Failed to delete Category. Status code: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      print('DioError while deleting category: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
      return false;
    } catch (e) {
      print('Error while deleting category: $e');
      return false;
    }
  }
}
