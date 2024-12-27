import 'package:dio/dio.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/main.dart';
import 'dart:convert';

class LaporanRepo {
  Future<GetAnaliticsCatagory> getAnaliticsCatagory() async {
    try {
      final dio = Dio();
      final token = await TokenManager().getToken();
      final response = await dio.get(
        '$mainUrl/transaction/seller/analitics/category',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return GetAnaliticsCatagory.fromJson(response.data);
      } else {
        throw Exception('Failed to load analytics category');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load analytics category');
    }
  }
}

class GetAnaliticsCatagory {
  String? status;
  String? message;
  Data? data;

  GetAnaliticsCatagory({
    this.status,
    this.message,
    this.data,
  });

  factory GetAnaliticsCatagory.fromRawJson(String str) =>
      GetAnaliticsCatagory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAnaliticsCatagory.fromJson(Map<String, dynamic> json) =>
      GetAnaliticsCatagory(
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
  List<Transaksi>? transaksi;

  Data({
    this.transaksi,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transaksi: json["transaksi"] == null
            ? []
            : List<Transaksi>.from(
                json["transaksi"]!.map((x) => Transaksi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transaksi": transaksi == null
            ? []
            : List<dynamic>.from(transaksi!.map((x) => x.toJson())),
      };
}

class Transaksi {
  String? kategori;
  int? jumlah;
  String? pendapatan;

  Transaksi({
    this.kategori,
    this.jumlah,
    this.pendapatan,
  });

  factory Transaksi.fromRawJson(String str) =>
      Transaksi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        kategori: json["Kategori"],
        jumlah: json["Jumlah"],
        pendapatan: json["Pendapatan"],
      );

  Map<String, dynamic> toJson() => {
        "Kategori": kategori,
        "Jumlah": jumlah,
        "Pendapatan": pendapatan,
      };
}
