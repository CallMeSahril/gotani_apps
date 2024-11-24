import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';

List<ModelCart> modelCartFromJson(String str) =>
    List<ModelCart>.from(json.decode(str).map((x) => ModelCart.fromJson(x)));

String modelCartToJson(List<ModelCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCart {
  int? id;
  int? cartId;
  int? productId;
  int? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  ModelProductCart? product;
  bool isSelected;

  ModelCart({
    this.id,
    this.cartId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.isSelected = false,
  });

  factory ModelCart.fromJson(Map<String, dynamic> json) => ModelCart(
        id: json["id"],
        cartId: json["cart_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product: json["product"] == null
            ? null
            : ModelProductCart.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };

  static Future<List<ModelCart>> fetchCarts() async {
    final token = await TokenManager().getToken();
    final response = await http.get(
      Uri.parse("$mainUrl/cart"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    print(response.statusCode);
    var respon = jsonDecode(response.body);
    print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String orders = json.encode(jsonResponse['data'][0]['items']);
      // print(orders);
      var hasil = modelCartFromJson(orders);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class ModelProductCart {
  int? id;
  int? userId;
  int? productCategoryId;
  String? name;
  int? stock;
  String? description;
  String? imageUrl;
  int? rating;
  int? totalRating;
  int? price;
  int? weight;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelProductCart({
    this.id,
    this.userId,
    this.productCategoryId,
    this.name,
    this.stock,
    this.description,
    this.imageUrl,
    this.rating,
    this.totalRating,
    this.price,
    this.weight,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelProductCart.fromJson(Map<String, dynamic> json) =>
      ModelProductCart(
        id: json["id"],
        userId: json["user_id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        stock: json["stock"],
        description: json["description"],
        imageUrl: json["image_url"],
        rating: json["rating"],
        totalRating: json["total_rating"],
        price: json["price"],
        weight: json["weight"],
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
        "product_category_id": productCategoryId,
        "name": name,
        "stock": stock,
        "description": description,
        "image_url": imageUrl,
        "rating": rating,
        "total_rating": totalRating,
        "price": price,
        "weight": weight,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
