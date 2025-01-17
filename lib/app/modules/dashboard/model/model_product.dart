import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';
import 'model_product_category.dart';
import 'model_seller.dart';

List<ModelProduct> modelProductFromJson(String str) => List<ModelProduct>.from(
    json.decode(str).map((x) => ModelProduct.fromJson(x)));

String modelProductToJson(List<ModelProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ModelProduct modelProductDetailFromJson(String str) =>
    ModelProduct.fromJson(json.decode(str));

String modelProductDetailToJson(ModelProduct data) =>
    json.encode(data.toJson());

class ModelProduct {
  int? id;
  int? userId;
  int? productCategoryId;
  String? name;
  int? stock;
  String? description;
  String? imageUrl;
  int? rating;
  int? totalRating;
  int? totalSales;
  int? price;
  int? weight;
  DateTime? createdAt;
  DateTime? updatedAt;
  ModelSeller? user;
  ModelProductCategory? productCategory;
  List<dynamic>? ratings;

  ModelProduct({
    this.id,
    this.userId,
    this.productCategoryId,
    this.name,
    this.stock,
    this.description,
    this.imageUrl,
    this.rating,
    this.totalRating,
    this.totalSales,
    this.price,
    this.weight,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.productCategory,
    this.ratings,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) => ModelProduct(
        id: json["id"],
        userId: json["user_id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        stock: json["stock"],
        description: json["description"],
        imageUrl: json["image_url"],
        rating: json["rating"],
        totalRating: json["total_rating"],
        totalSales: json["total_sales"],
        price: json["price"],
        weight: json["weight"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : ModelSeller.fromJson(json["user"]),
        productCategory: json["product_category"] == null
            ? null
            : ModelProductCategory.fromJson(json["product_category"]),
        ratings: json["ratings"] == null
            ? []
            : List<dynamic>.from(json["ratings"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_category_id": productCategoryId,
        "name": name,
        "stock": stock,
        "description": description,
        "image_url": imageUrl,
        "rating": rating,
        "total_rating": totalRating,
        "total_sales": totalSales,
        "price": price,
        "weight": weight,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "product_category": productCategory?.toJson(),
        "ratings":
            ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
      };

  static Future<List<ModelProduct>> fetchRecords() async {
    final token = await TokenManager().getToken();
    final response = await http.get(
      Uri.parse("$mainUrl/products"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    // print(response.statusCode);
    // var respon = jsonDecode(response.body);
    // print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data']);
      var hasil = modelProductFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<ModelProduct>> searchProduct(String query) async {
    final token = await TokenManager().getToken();
    final response =
        await http.post(Uri.parse("$mainUrl/products/search"), headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
    }, body: {
      "search": query
    });
    print(response.statusCode);
    var respon = jsonDecode(response.body);
    print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data']);
      // print(orders);
      var hasil = modelProductFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<ModelProduct> fetchDetailsRecords({required String id}) async {
    final token = await TokenManager().getToken();
    final response = await http.get(
      Uri.parse("$mainUrl/products/$id"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    print(response.statusCode);
    var respon = jsonDecode(response.body);
    print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data']);
      var hasil = modelProductDetailFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
