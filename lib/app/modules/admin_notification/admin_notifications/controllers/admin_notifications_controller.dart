import 'dart:io';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminNotificationsController extends GetxController {
  var data = <Notification>[].obs;

  Future fetchDataTransaction() async {
    final RepoTransactinPacked repoTransactinPacked = RepoTransactinPacked();
    final respone = await repoTransactinPacked.getTransactionPacked();
    if (respone != null) {
      data.value = respone.data!;
    }
  }

  @override
  void onInit() {
    fetchDataTransaction();
    super.onInit();
  }
  // final notifications = <Notification>[
  //   Notification(createdAt: '03/10/2024', customer: 'halim123', status: 'Baru'),
  //   Notification(date: '03/10/2024', username: 'kia31', status: 'Baru'),
  //   Notification(date: '02/10/2024', username: 'epd_12', status: 'Diproses'),
  //   Notification(date: '02/10/2024', username: 'yul123', status: 'Diproses'),
  // ];
}

// Model
// class Notification {
//   final String date;
//   final String username;
//   final String status;

//   Notification({
//     required this.date,
//     required this.username,
//     required this.status,
//   });
// }

class RepoTransactinPacked {
  Future<TransactinPacked?> getTransactionPacked() async {
    try {
      final token = await TokenManager().getToken();
      final response = await http.get(
        Uri.parse("$mainUrl/transaction/packed/get-by-seller-id"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final data = TransactinPacked.fromJson(json.decode(response.body));
        return data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

class TransactinPacked {
  final String? status;
  final String? message;
  final List<Notification>? data;

  TransactinPacked({
    this.status,
    this.message,
    this.data,
  });

  factory TransactinPacked.fromRawJson(String str) =>
      TransactinPacked.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactinPacked.fromJson(Map<String, dynamic> json) =>
      TransactinPacked(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Notification>.from(
                json["data"]!.map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Notification {
  final int? id;
  final int? customerId;
  final int? sellerId;
  final String? orderId;
  final int? total;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customer? customer;
  final List<TransactionItem>? transactionItems;

  Notification({
    this.id,
    this.customerId,
    this.sellerId,
    this.orderId,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.transactionItems,
  });

  factory Notification.fromRawJson(String str) =>
      Notification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        customerId: json["customer_id"],
        sellerId: json["seller_id"],
        orderId: json["order_id"],
        total: json["total"],
        status: json["status"],
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer": customer?.toJson(),
        "transaction_items": transactionItems == null
            ? []
            : List<dynamic>.from(transactionItems!.map((x) => x.toJson())),
      };
}

class Customer {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final int? balance;
  final dynamic storeName;
  final dynamic storeLogo;
  final dynamic storeAddress;
  final dynamic storeProvince;
  final dynamic storeProvinceId;
  final dynamic storeCity;
  final dynamic storeCityId;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
  final int? id;
  final int? transactionId;
  final int? productId;
  final int? quantity;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TransactionItem({
    this.id,
    this.transactionId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
