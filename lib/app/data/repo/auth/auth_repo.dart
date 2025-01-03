import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gotani_apps/main.dart';

class AuthRepo {
  Future<List> register(UploadUser data) async {
    final dio = Dio();

    // Create FormData with the necessary fields
    FormData formData = FormData.fromMap({
      'name': data.name,
      'email': data.email,
      'password': data.password,
      'store_name': data.storeName,
      'store_address': data.storeAddress,
      'store_province': data.storeProvince,
      'store_province_id': data.storeProvinceId,
      'store_city': data.storeCity,
      'store_city_id': data.storeCityId,
      // Attach the file as a MultipartFile
      'store_logo': await MultipartFile.fromFile(data.storeLogoUpload!.path),
    });

    try {
      // Make the POST request with FormData
      final response =
          await dio.post('$mainUrl/register-seller', data: formData);

      if (response.statusCode == 200) {
        if (response.data['status'] == 'success') {
          return ['success'];
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
      print('Error occurred: $e');
    }
  }
}

class UploadUser {
  String? name;
  String? email;
  String? password;
  String? storeName;
  File? storeLogoUpload;
  String? storeAddress;
  String? storeProvince;
  String? storeProvinceId;
  String? storeCity;
  String? storeCityId;

  UploadUser({
    this.name,
    this.email,
    this.storeName,
    this.password,
    this.storeAddress,
    this.storeLogoUpload,
    this.storeProvince,
    this.storeProvinceId,
    this.storeCity,
    this.storeCityId,
  });
}

class UserModel {
  String? name;
  String? email;
  String? role;
  String? password;
  String? storeName;
  String? storeLogo;
  File? storeLogoUpload;
  String? storeAddress;
  String? storeProvince;
  String? storeProvinceId;
  String? storeCity;
  String? storeCityId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  UserModel({
    this.name,
    this.email,
    this.role,
    this.storeName,
    this.password,
    this.storeLogo,
    this.storeAddress,
    this.storeLogoUpload,
    this.storeProvince,
    this.storeProvinceId,
    this.storeCity,
    this.storeCityId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        role: json["role"],
        storeName: json["store_name"],
        storeLogo: json["store_logo"],
        storeAddress: json["store_address"],
        storeProvince: json["store_province"],
        storeProvinceId: json["store_province_id"],
        storeCity: json["store_city"],
        storeCityId: json["store_city_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "role": role,
        "store_name": storeName,
        "store_logo": storeLogo,
        "store_address": storeAddress,
        "store_province": storeProvince,
        "store_province_id": storeProvinceId,
        "store_city": storeCity,
        "store_city_id": storeCityId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
