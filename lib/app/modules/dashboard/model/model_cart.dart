import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';

class ModelCart {
  final String? status;
  final String? message;
  final List<DataCartScreen>? data;

  ModelCart({
    this.status,
    this.message,
    this.data,
  });

  factory ModelCart.fromRawJson(String str) =>
      ModelCart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelCart.fromJson(Map<String, dynamic> json) => ModelCart(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataCartScreen>.from(
                json["data"]!.map((x) => DataCartScreen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataCartScreen {
  final int? id;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Item>? items;

  DataCartScreen({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory DataCartScreen.fromRawJson(String str) =>
      DataCartScreen.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataCartScreen.fromJson(Map<String, dynamic> json) => DataCartScreen(
        id: json["id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  bool isSelected;
  int? id;
  int? cartId;
  int? productId;
  int? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  Item({
    this.isSelected = false,
    this.id,
    this.cartId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
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
}

class Product {
  final int? id;
  final int? userId;
  final int? productCategoryId;
  final String? name;
  final int? stock;
  final String? description;
  final String? imageUrl;
  final int? rating;
  final int? totalRating;
  final int? totalSales;
  final int? price;
  final int? weight;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
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
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
      };
}

class RepositoriModelCart {
  static Future<ModelCart> fetchCarts() async {
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
      return ModelCart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  }
}
// List<ModelCart> modelCartFromJson(String str) =>
//     List<ModelCart>.from(json.decode(str).map((x) => ModelCart.fromJson(x)));

// String modelCartToJson(List<ModelCart> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ModelCart {
//   int? id;
//   int? cartId;
//   int? productId;
//   int? quantity;
//   int? price;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   ModelProductCart? product;
//   bool isSelected;

//   ModelCart({
//     this.id,
//     this.cartId,
//     this.productId,
//     this.quantity,
//     this.price,
//     this.createdAt,
//     this.updatedAt,
//     this.product,
//     this.isSelected = false,
//   });

//   factory ModelCart.fromJson(Map<String, dynamic> json) => ModelCart(
//         id: json["id"],
//         cartId: json["cart_id"],
//         productId: json["product_id"],
//         quantity: json["quantity"],
//         price: json["price"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         product: json["product"] == null
//             ? null
//             : ModelProductCart.fromJson(json["product"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "cart_id": cartId,
//         "product_id": productId,
//         "quantity": quantity,
//         "price": price,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "product": product?.toJson(),
//       };

//   static Future<List<ModelCart>> fetchCarts() async {
//     final token = await TokenManager().getToken();
//     final response = await http.get(
//       Uri.parse("$mainUrl/cart"),
//       headers: {
//         HttpHeaders.authorizationHeader: "Bearer $token",
//       },
//     );
//     print(response.statusCode);
//     var respon = jsonDecode(response.body);
//     print(respon);
//     if (response.statusCode == 200) {
//       Map<String, dynamic> jsonResponse = json.decode(response.body);
//       String orders = json.encode(jsonResponse['data'][0]['items']);
//       // print(orders);
//       var hasil = modelCartFromJson(orders);
//       return hasil;
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }

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
