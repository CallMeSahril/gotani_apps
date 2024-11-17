import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gotani_apps/app/core/services/dio.h.dart';

class ProductService {
  final Dio dio = Dio();

  Future<List> getProduct(int productId) async {
    try {
      final response = await dioCustom.get('products/$productId');

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        return [];
      }
    } catch (e) {
      print('Error while fetching product: $e');
      return [];
    }
  }

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
        log(response.statusCode.toString());
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