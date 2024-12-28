import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/main.dart';

class TransaksiRepo {
  Future<List<DataTransaksi>?> getHistory() async {
    try {
      final dio = Dio();
      final token = await TokenManager().getToken();
      final response = await dio.get(
        '$mainUrl/transaction/seller/transaction/completed',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return List<DataTransaksi>.from(
            response.data['data'].map((x) => DataTransaksi.fromJson(x)));
      } else {
        throw Exception('Failed to load analytics category');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to load analytics category');
    }
  }
}

class TransaksiModel {
  String? status;
  String? message;
  List<DataTransaksi>? data;

  TransaksiModel({
    this.status,
    this.message,
    this.data,
  });

  factory TransaksiModel.fromRawJson(String str) =>
      TransaksiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransaksiModel.fromJson(Map<String, dynamic> json) => TransaksiModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DataTransaksi>.from(
                json["data"]!.map((x) => DataTransaksi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataTransaksi {
  int? id;
  int? customerId;
  int? sellerId;
  String? orderId;
  int? total;
  String? status;
  String? paymentUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  Customer? customer;
  List<TransactionItem>? transactionItems;

  DataTransaksi({
    this.id,
    this.customerId,
    this.sellerId,
    this.orderId,
    this.total,
    this.status,
    this.paymentUrl,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.transactionItems,
  });

  factory DataTransaksi.fromRawJson(String str) =>
      DataTransaksi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataTransaksi.fromJson(Map<String, dynamic> json) => DataTransaksi(
        id: json["id"],
        customerId: json["customer_id"],
        sellerId: json["seller_id"],
        orderId: json["order_id"],
        total: json["total"],
        status: json["status"],
        paymentUrl: json["payment_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        transactionItems: json["transaction_items"] == null
            ? []
            : List<TransactionItem>.from(json["transaction_items"]!
                .map((x) => TransactionItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "seller_id": sellerId,
        "order_id": orderId,
        "total": total,
        "status": status,
        "payment_url": paymentUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer": customer?.toJson(),
        "transaction_items": transactionItems == null
            ? []
            : List<dynamic>.from(transactionItems!.map((x) => x.toJson())),
      };
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? role;
  int? balance;
  dynamic storeName;
  dynamic storeLogo;
  dynamic storeAddress;
  dynamic storeProvince;
  dynamic storeProvinceId;
  dynamic storeCity;
  dynamic storeCityId;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Customer({
    this.id,
    this.name,
    this.email,
    this.role,
    this.balance,
    this.storeName,
    this.storeLogo,
    this.storeAddress,
    this.storeProvince,
    this.storeProvinceId,
    this.storeCity,
    this.storeCityId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        balance: json["balance"],
        storeName: json["store_name"],
        storeLogo: json["store_logo"],
        storeAddress: json["store_address"],
        storeProvince: json["store_province"],
        storeProvinceId: json["store_province_id"],
        storeCity: json["store_city"],
        storeCityId: json["store_city_id"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "balance": balance,
        "store_name": storeName,
        "store_logo": storeLogo,
        "store_address": storeAddress,
        "store_province": storeProvince,
        "store_province_id": storeProvinceId,
        "store_city": storeCity,
        "store_city_id": storeCityId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class TransactionItem {
  int? id;
  int? transactionId;
  int? productId;
  int? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  TransactionItem({
    this.id,
    this.transactionId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory TransactionItem.fromRawJson(String str) =>
      TransactionItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      TransactionItem(
        id: json["id"],
        transactionId: json["transaction_id"],
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
        "transaction_id": transactionId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
      };
}

class Product {
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
  ProductCategory? productCategory;

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
    this.productCategory,
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
        productCategory: json["product_category"] == null
            ? null
            : ProductCategory.fromJson(json["product_category"]),
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
        "product_category": productCategory?.toJson(),
      };
}

class ProductCategory {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductCategory({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductCategory.fromRawJson(String str) =>
      ProductCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
