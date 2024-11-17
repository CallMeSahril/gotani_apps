import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';

List<ModelKabupaten> modelKabupatenFromJson(String str) =>
    List<ModelKabupaten>.from(
        json.decode(str).map((x) => ModelKabupaten.fromJson(x)));

String modelkabupatenToJson(List<ModelKabupaten> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelKabupaten {
  String? cityId;
  String? provinceId;
  String? province;
  String? type;
  String? cityName;
  String? postalCode;

  ModelKabupaten({
    this.cityId,
    this.provinceId,
    this.province,
    this.type,
    this.cityName,
    this.postalCode,
  });

  factory ModelKabupaten.fromJson(Map<String, dynamic> json) => ModelKabupaten(
        cityId: json["city_id"],
        provinceId: json["province_id"],
        province: json["province"],
        type: json["type"],
        cityName: json["city_name"],
        postalCode: json["postal_code"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "province_id": provinceId,
        "province": province,
        "type": type,
        "city_name": cityName,
        "postal_code": postalCode,
      };

  static Future<List<ModelKabupaten>> fetchKabupaten(String idProv) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse("$mainUrl/cities/$idProv"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
      },
    );
    print(response.statusCode);
    var respon = jsonDecode(response.body);
    print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data']);
      // print(orders);
      var hasil = modelKabupatenFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
