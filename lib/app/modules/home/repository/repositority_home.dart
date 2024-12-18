import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/main.dart';
// import 'package:http/http.dart' as http;

class RepositorityHome {
  Future<SellerAnaliticsModel> getSellerAnalitics() async {
    try {
      final token = await TokenManager().getToken();

      var dio = Dio();
      var response = await dio.get(
        '$mainUrl/transaction/seller/analitics',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer $token",
          },
        ),
      );

      return SellerAnaliticsModel.fromJson(response.data);
    } catch (e) {
      print("Error fetching seller analytics: $e");
      rethrow;
    }
  }
}

class SellerAnaliticsModel {
  String? status;
  String? message;
  SellerAnaliticsData? data;

  SellerAnaliticsModel({
    this.status,
    this.message,
    this.data,
  });

  factory SellerAnaliticsModel.fromRawJson(String str) =>
      SellerAnaliticsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerAnaliticsModel.fromJson(Map<String, dynamic> json) =>
      SellerAnaliticsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : SellerAnaliticsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class SellerAnaliticsData {
  int? totalTransaksi;
  int? totalProduk;
  int? transaksiBaru;

  SellerAnaliticsData({
    this.totalTransaksi,
    this.totalProduk,
    this.transaksiBaru,
  });

  factory SellerAnaliticsData.fromRawJson(String str) =>
      SellerAnaliticsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerAnaliticsData.fromJson(Map<String, dynamic> json) =>
      SellerAnaliticsData(
        totalTransaksi: json["totalTransaksi"],
        totalProduk: json["totalProduk"],
        transaksiBaru: json["transaksiBaru"],
      );

  Map<String, dynamic> toJson() => {
        "totalTransaksi": totalTransaksi,
        "totalProduk": totalProduk,
        "transaksiBaru": transaksiBaru,
      };
}
