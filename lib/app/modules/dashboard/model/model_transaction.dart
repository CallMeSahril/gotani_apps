import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

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
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelTransaction({
    this.id,
    this.customerId,
    this.sellerId,
    this.orderId,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelTransaction.fromJson(Map<String, dynamic> json) =>
      ModelTransaction(
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
      };

  static Future<List<ModelTransaction>> fetchTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse("$mainUrl/transaction"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${prefs.getString("token")}",
      },
    );
    print(response.statusCode);
    var respon = jsonDecode(response.body);
    print(respon);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String transaction = json.encode(jsonResponse['data']);
      // print(orders);
      var hasil = modelTransactionFromJson(transaction);
      return hasil;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
