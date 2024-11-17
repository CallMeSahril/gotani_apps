import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';

List<ModelDeliveryType> modelDeliveryTypeFromJson(String str) =>
    List<ModelDeliveryType>.from(
        json.decode(str).map((x) => ModelDeliveryType.fromJson(x)));

String modelDeliveryTypeToJson(List<ModelDeliveryType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDeliveryType {
  String? service;
  String? description;
  List<Cost>? cost;

  ModelDeliveryType({
    this.service,
    this.description,
    this.cost,
  });

  factory ModelDeliveryType.fromJson(Map<String, dynamic> json) =>
      ModelDeliveryType(
        service: json["service"],
        description: json["description"],
        cost: json["cost"] == null
            ? []
            : List<Cost>.from(json["cost"]!.map((x) => Cost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service,
        "description": description,
        "cost": cost == null
            ? []
            : List<dynamic>.from(cost!.map((x) => x.toJson())),
      };

  static Future<List<ModelDeliveryType>> fetchDeliveryType({
    required String courier,
    required int origin,
    required int destination,
    required int weight,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse("$mainUrl/check-shipping-cost"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
      },
      body: {
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier
      },
    );
    print(response.statusCode);
    var respon = jsonDecode(response.body);
    print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data']['costs']);
      // print(orders);
      var hasil = modelDeliveryTypeFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class Cost {
  int? value;
  String? etd;
  String? note;

  Cost({
    this.value,
    this.etd,
    this.note,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => Cost(
        value: json["value"],
        etd: json["etd"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "etd": etd,
        "note": note,
      };
}
