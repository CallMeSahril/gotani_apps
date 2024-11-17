import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';

List<ModelProvince> modelProvinceFromJson(String str) =>
    List<ModelProvince>.from(
        json.decode(str).map((x) => ModelProvince.fromJson(x)));

String modelProvinceToJson(List<ModelProvince> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProvince {
  String? provinceId;
  String? province;

  ModelProvince({
    this.provinceId,
    this.province,
  });

  factory ModelProvince.fromJson(Map<String, dynamic> json) => ModelProvince(
        provinceId: json["province_id"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province": province,
      };

  static Future<List<ModelProvince>> fetchProvince() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse("$mainUrl/provinces"),
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
      var hasil = modelProvinceFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
