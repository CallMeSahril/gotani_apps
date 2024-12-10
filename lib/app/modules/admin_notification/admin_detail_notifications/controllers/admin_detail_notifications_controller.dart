import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:gotani_apps/app/core/helper/shared_preferences_helper.dart';
import 'package:gotani_apps/main.dart';
import 'package:http/http.dart' as http;

class AdminDetailNotificationsController extends GetxController {
  final dataDetail = Rx<Data?>(null);
  var isLoading = false.obs;
  var isId = ''.obs;
  final notification = {
    'id': '#12345',
    'date': DateTime(2024, 10, 4),
    'userName': 'halim123',
    'address': 'Tambon Tunong',
    'phone': '082367895432',
    'items': [
      {'name': 'Pupuk NPK', 'quantity': 5, 'price': 400000},
      {'name': 'Pupuk Urea', 'quantity': 5, 'price': 1350000},
    ]
  }.obs;

  double get totalPrice {
    Object? items = dataDetail.value?.transactionItems;

    if (items != null && items is List<TransactionItem>) {
      return items.fold(0.0, (sum, item) {
        double quantity = (item.quantity ?? 0).toDouble();
        double price = (item.price ?? 0).toDouble();

        return sum + (quantity * price);
      });
    }

    return 0.0;
  }

  Future fetchDataTransactionDetail() async {
    isLoading.value = true;
    final response = await RepoDetailTransaction()
        .getTransactionDetailPacked(isId.value == ' ' ? '1' : isId.value);
    if (response != null) {
      dataDetail.value = response.data;
    }
    isLoading.value = false;
  }

  Future getTransactionDelivered() async {
    final response = await RepoDetailTransaction()
        .getTransactionDelivered(isId.value == ' ' ? '1' : isId.value);
    if (response?.data != null) {
      Get.snackbar('Success', 'Order is being processed');
    } else {
      Get.snackbar('Error', '${response?.message}');
    }
  }

  @override
  void onInit() {
    isId.value = "${Get.arguments} ";
    fetchDataTransactionDetail();
    super.onInit();
  }

  void processOrder() {
    getTransactionDelivered();
  }

  void cancelOrder() {
    Get.snackbar('Cancelled', 'Order has been cancelled');
  }
}

class RepoDetailTransaction {
  Future<TransactionDetail?> getTransactionDetailPacked(String id) async {
    try {
      final token = await TokenManager().getToken();
      final response = await http.get(
        Uri.parse("$mainUrl/transaction/$id"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        final data = TransactionDetail.fromJson(json.decode(response.body));
        return data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<TransactionDetail?> getTransactionDelivered(String id) async {
    try {
      final token = await TokenManager().getToken();
      final response = await http.post(
        Uri.parse("$mainUrl/transaction/$id/delivered"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );
      print(response.body);
      final data = TransactionDetail.fromJson(json.decode(response.body));
      print(data);
      return data;
    } catch (e) {
      return null;
    }
  }
}

class TransactionDelivered {
  final String? status;
  final String? message;
  final Data? data;

  TransactionDelivered({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionDelivered.fromRawJson(String str) =>
      TransactionDelivered.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionDelivered.fromJson(Map<String, dynamic> json) =>
      TransactionDelivered(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class TransactionDetail {
  final String? status;
  final String? message;
  final Data? data;

  TransactionDetail({
    this.status,
    this.message,
    this.data,
  });

  factory TransactionDetail.fromRawJson(String str) =>
      TransactionDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      TransactionDetail(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? customerId;
  final int? sellerId;
  final String? orderId;
  final int? total;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customer? customer;
  final Customer? seller;
  final List<TransactionItem>? transactionItems;

  Data({
    this.id,
    this.customerId,
    this.sellerId,
    this.orderId,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.seller,
    this.transactionItems,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        seller:
            json["seller"] == null ? null : Customer.fromJson(json["seller"]),
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
        "seller": seller?.toJson(),
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
  final String? storeName;
  final String? storeLogo;
  final String? storeAddress;
  final String? storeProvince;
  final String? storeProvinceId;
  final String? storeCity;
  final String? storeCityId;
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
