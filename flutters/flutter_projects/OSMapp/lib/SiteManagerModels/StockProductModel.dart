// To parse this JSON data, do
//
//     final stockProductModel = stockProductModelFromJson(jsonString);

import 'dart:convert';

StockProductModel stockProductModelFromJson(String str) => StockProductModel.fromJson(json.decode(str));

String stockProductModelToJson(StockProductModel data) => json.encode(data.toJson());

class StockProductModel {
  int status;
  String message;
  List<StockDatum> data;

  StockProductModel({
    this.status,
    this.message,
    this.data,
  });

  factory StockProductModel.fromJson(Map<String, dynamic> json) => StockProductModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<StockDatum>.from(json["data"].map((x) => StockDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StockDatum {
  String productId;
  String productName;
  int quantity;
  int usedQuanity;
  int remainingQuanity;

  StockDatum({
    this.productId,
    this.productName,
    this.quantity,
    this.usedQuanity,
    this.remainingQuanity,
  });

  factory StockDatum.fromJson(Map<String, dynamic> json) => StockDatum(
    productId: json["product_id"] == null ? null : json["product_id"],
    productName: json["product_name"] == null ? null : json["product_name"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    usedQuanity: json["used_quanity"] == null ? null : json["used_quanity"],
    remainingQuanity: json["remaining_quanity"] == null ? null : json["remaining_quanity"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "product_name": productName == null ? null : productName,
    "quantity": quantity == null ? null : quantity,
    "used_quanity": usedQuanity == null ? null : usedQuanity,
    "remaining_quanity": remainingQuanity == null ? null : remainingQuanity,
  };
}
