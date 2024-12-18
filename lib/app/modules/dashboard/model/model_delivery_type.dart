import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';

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
    required String origin,
    required String destination,
    required String weight,
  }) async {
    print(
      {
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier
      },
    );
    final token = await TokenManager().getToken();
    final response = await http.post(
      Uri.parse("$mainUrl/check-shipping-cost"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
      body: {
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier
      },
    );
    // print(response.body);
    // var respon = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data'][0]['costs']);
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
