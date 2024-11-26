import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';
import 'model_product.dart';

List<ModelCategory> modelCategoryFromJson(String str) =>
    List<ModelCategory>.from(
        json.decode(str).map((x) => ModelCategory.fromJson(x)));

String modelCategoryToJson(List<ModelCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCategory {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ModelProduct>? products;

  ModelCategory({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory ModelCategory.fromJson(Map<String, dynamic> json) => ModelCategory(
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
        products: json["products"] == null
            ? []
            : List<ModelProduct>.from(
                json["products"]!.map((x) => ModelProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };

  static Future<List<ModelCategory>> fetchCategory() async {
    final token = await TokenManager().getToken();
    final response =
        await http.get(Uri.parse("$mainUrl/products-category"), headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    print(response.statusCode);
    var respon = jsonDecode(response.body);
    print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data']);
      // print(orders);
      var hasil = modelCategoryFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
