import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../../main.dart';
import '../../../core/helper/shared_preferences_helper.dart';
import 'model_profile.dart';

List<ModelTransaction> modelTransactionFromJson(String str) =>
    List<ModelTransaction>.from(
        json.decode(str).map((x) => ModelTransaction.fromJson(x)));

String modelTransactionToJson(List<ModelTransaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTransaction {
  int? id;
  int? customerId;
  int? sellerId;
  String? orderId;
  int? total;
  String? status;
  String? paymentUrl;

  DateTime? createdAt;
  DateTime? updatedAt;
  ModelProfile? customer;
  ModelProfile? seller;
  List<ModelTransactionItem>? transactionItems;

  ModelTransaction({
    this.id,
    this.customerId,
    this.sellerId,
    this.orderId,
    this.total,
    this.paymentUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.seller,
    this.transactionItems,
  });

  factory ModelTransaction.fromJson(Map<String, dynamic> json) =>
      ModelTransaction(
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
            : ModelProfile.fromJson(json["customer"]),
        seller: json["seller"] == null
            ? null
            : ModelProfile.fromJson(json["seller"]),
        transactionItems: json["transaction_items"] == null
            ? []
            : List<ModelTransactionItem>.from(json["transaction_items"]!
                .map((x) => ModelTransactionItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "seller_id": sellerId,
        "order_id": orderId,
        "total": total,
        "payment_url": paymentUrl,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "customer": customer?.toJson(),
        "seller": seller?.toJson(),
        "transaction_items": transactionItems == null
            ? []
            : List<dynamic>.from(transactionItems!.map((x) => x.toJson())),
      };

  static Future<List<ModelTransaction>> fetchTransactions() async {
    final token = await TokenManager().getToken();
    final response = await http.get(
      Uri.parse("$mainUrl/transaction"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    // print(response.statusCode);
    // var respon = jsonDecode(response.body);
    // print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String transaction = json.encode(jsonResponse['data']);
      var hasil = modelTransactionFromJson(transaction);
      return hasil;
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}

class ModelTransactionItem {
  int? id;
  int? transactionId;
  int? productId;
  int? quantity;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelTransactionItem({
    this.id,
    this.transactionId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelTransactionItem.fromJson(Map<String, dynamic> json) =>
      ModelTransactionItem(
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
