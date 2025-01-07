import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/app/core/services/dio.h.dart';

class ProductService {
  ProductService() {
    configureDioWithToken();
  }

  Future<GetProduct?> getProduct(int productId) async {
    try {
      final response = await dioCustom.get('products/$productId');

      if (response.statusCode == 200) {
        GetProduct getProduct = GetProduct.fromJson(response.data);
        return getProduct;
      } else {
        return null;
      }
    } catch (e) {
      print('Error while fetching product: $e');
      return null;
    }
  }

  Future<List> postProduct({
    required int productCategoryId,
    required String name,
    required int stock,
    required String description,
    required String imagePath,
    required int price,
    required int weight,
    required BuildContext context,
  }) async {
    try {
      // Konversi imagePath menjadi File
      File imageFile = File(imagePath);

      // Membuat FormData untuk mengirim data termasuk file
      FormData formData = FormData.fromMap({
        'product_category_id': productCategoryId.toString(),
        'name': name,
        'stock': stock.toString(),
        'description': description,
        'price': price.toString(),
        'weight': weight.toString(),
        'gambar':
            await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });

      // Melakukan POST request
      final response = await dioCustom.post('products', data: formData);

      if (response.statusCode == 200) {
        if (response.data['message'] != 'success create data') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.data['message'].toString())),
          );

          return ['error'];
        } else {
          return ['berhasil'];
        }
      } else {
        return [];
      }
    } catch (e) {
      print('Error while posting product: $e');
      return [];
    }
  }

  Future<List> putProduct({
    required int productCategoryId,
    required String name,
    required int stock,
    required String description,
    required String imagePath,
    required int price,
    required int weight,
    required BuildContext context,
    required String id,
  }) async {
    try {
      final dio = Dio();
      TokenManager tokenManager = TokenManager();
      String? token = await tokenManager.getToken();
      // Konversi imagePath menjadi File
      File imageFile = File(imagePath);
      // Membuat FormData untuk mengirim data termasuk file
      FormData data = FormData.fromMap({
        'product_category_id': productCategoryId.toString(),
        'name': name,
        'stock': stock.toString(),
        'description': description,
        'price': price.toString(),
        'weight': weight.toString(),
        if (imagePath.contains("http")) ...{
          'image_url': imagePath,
        },
        if (!imagePath.contains("http")) ...{
          'image_url': await MultipartFile.fromFile(imageFile.path,
              filename: 'image.jpg'),
        }
      });
      // Melakukan POST request
      final response =
          await dio.post('https://gotani.ahatest.my.id/api/products/$id',
              data: data,
              options: Options(headers: {
                'Authorization': 'Bearer $token',
              }));

      if (response.statusCode == 200) {
        if (response.data['message'] != 'Success updated data') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.data['message'].toString())),
          );

          return ['error'];
        } else {
          return ['berhasil'];
        }
      } else {
        return [];
      }
    } catch (e) {
      print('Error while posting product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
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

class GetProduct {
  final String? status;
  final String? message;
  final Data? data;

  GetProduct({
    this.status,
    this.message,
    this.data,
  });

  factory GetProduct.fromRawJson(String str) =>
      GetProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? userId;
  final int? productCategoryId;
  final String? name;
  final int? stock;
  final String? description;
  final String? imageUrl;
  final int? rating;
  final int? totalRating;
  final int? totalSales;
  final int? price;
  final int? weight;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;
  final ProductCategory? productCategory;
  final List<dynamic>? ratings;

  Data({
    this.id,
    this.userId,
    this.productCategoryId,
    this.name,
    this.stock,
    this.description,
    this.imageUrl,
    this.rating,
    this.totalRating,
    this.totalSales,
    this.price,
    this.weight,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.productCategory,
    this.ratings,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        stock: json["stock"],
        description: json["description"],
        imageUrl: json["image_url"],
        rating: json["rating"],
        totalRating: json["total_rating"],
        totalSales: json["total_sales"],
        price: json["price"],
        weight: json["weight"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        productCategory: json["product_category"] == null
            ? null
            : ProductCategory.fromJson(json["product_category"]),
        ratings: json["ratings"] == null
            ? []
            : List<dynamic>.from(json["ratings"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_category_id": productCategoryId,
        "name": name,
        "stock": stock,
        "description": description,
        "image_url": imageUrl,
        "rating": rating,
        "total_rating": totalRating,
        "total_sales": totalSales,
        "price": price,
        "weight": weight,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "product_category": productCategory?.toJson(),
        "ratings":
            ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
      };
}

class ProductCategory {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductCategory({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductCategory.fromRawJson(String str) =>
      ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final int? balance;
  final String? storeName;
  final String? storeLogo;
  final String? storeAddress;
  final String? storeProvince;
  final String? storeProvinceId;
  final String? storeCity;
  final String? storeCityId;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.balance,
    this.storeName,
    this.storeLogo,
    this.storeAddress,
    this.storeProvince,
    this.storeProvinceId,
    this.storeCity,
    this.storeCityId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        balance: json["balance"],
        storeName: json["store_name"],
        storeLogo: json["store_logo"],
        storeAddress: json["store_address"],
        storeProvince: json["store_province"],
        storeProvinceId: json["store_province_id"],
        storeCity: json["store_city"],
        storeCityId: json["store_city_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "balance": balance,
        "store_name": storeName,
        "store_logo": storeLogo,
        "store_address": storeAddress,
        "store_province": storeProvince,
        "store_province_id": storeProvinceId,
        "store_city": storeCity,
        "store_city_id": storeCityId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
