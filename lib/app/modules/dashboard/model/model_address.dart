import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';

List<ModelAddress> modelAddressFromJson(String str) => List<ModelAddress>.from(
    json.decode(str).map((x) => ModelAddress.fromJson(x)));

String modelAddressToJson(List<ModelAddress> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelAddress {
  int? id;
  int? userId;
  String? name;
  String? phone;
  String? address;
  String? province;
  String? provinceId;
  String? city;
  String? cityId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelAddress({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.address,
    this.province,
    this.provinceId,
    this.city,
    this.cityId,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelAddress.fromJson(Map<String, dynamic> json) => ModelAddress(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        province: json["province"],
        provinceId: json["province_id"],
        city: json["city"],
        cityId: json["city_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "address": address,
        "province": province,
        "province_id": provinceId,
        "city": city,
        "city_id": cityId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  static Future<List<ModelAddress>> fetchAddress() async {
    final token = await TokenManager().getToken();
    final response = await http.get(
      Uri.parse("$mainUrl/addresses"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    // print(response.statusCode);
    // var respon = jsonDecode(response.body);
    // print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String data = json.encode(jsonResponse['data']);
      var hasil = modelAddressFromJson(data);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
