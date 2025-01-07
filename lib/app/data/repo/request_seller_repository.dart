import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';

class RequestSellerRepository {
  Future<void> createRequest(RequestSellerModel data) async {
    final dio = Dio();
    String? token = await TokenManager().getToken();

    dio.options.headers['Authorization'] = 'Bearer $token';

    FormData formData = FormData.fromMap({
      'storeName': data.storeName,
      // 'storeLogo': await MultipartFile.fromFile(data.storeLogo!.path),
      'storeAddress': data.storeAddress,
      'storeProvince': data.storeProvince,
      'storeProvinceId': data.storeProvinceId,
      'storeCity': data.storeCity,
      'storeCityId': data.storeCityId,
    });

    try {
      final response = await dio.post(
        'https://gotani.ahatest.my.id/api/request-sellers',
        data: formData,
      );
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}

class RequestSellerModel {
  String? storeName;
  File? storeLogo;
  String? storeAddress;
  String? storeProvince;
  String? storeProvinceId;
  String? storeCity;
  String? storeCityId;

  RequestSellerModel({
    this.storeName,
    this.storeLogo,
    this.storeAddress,
    this.storeProvince,
    this.storeProvinceId,
    this.storeCity,
    this.storeCityId,
  });
}
