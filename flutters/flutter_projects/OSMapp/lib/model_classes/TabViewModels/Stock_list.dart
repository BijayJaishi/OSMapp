// To parse this JSON data, do
//
//     final stockList = stockListFromJson(jsonString);

import 'dart:convert';

StockList stockListFromJson(String str) => StockList.fromJson(json.decode(str));

String stockListToJson(StockList data) => json.encode(data.toJson());

class StockList {
  int status;
  String message;
  List<SiteDatum> data;

  StockList({
    this.status,
    this.message,
    this.data,
  });

  factory StockList.fromJson(Map<String, dynamic> json) => StockList(
    status: json["status"],
    message: json["message"],
    data: List<SiteDatum>.from(json["data"].map((x) => SiteDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SiteDatum {
  DateTime date;
  List<Stock> stock;

  SiteDatum({
    this.date,
    this.stock,
  });

  factory SiteDatum.fromJson(Map<String, dynamic> json) => SiteDatum(
    date: DateTime.parse(json["date"]),
    stock: List<Stock>.from(json["stock"].map((x) => Stock.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "stock": List<dynamic>.from(stock.map((x) => x.toJson())),
  };
}

class Stock {
  String productId;
  String productName;
  int quantity;
  int usedQuanity;
  int remainingQuanity;

  Stock({
    this.productId,
    this.productName,
    this.quantity,
    this.usedQuanity,
    this.remainingQuanity,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
    productId: json["product_id"],
    productName: json["product_name"],
    quantity: json["quantity"],
    usedQuanity: json["used_quanity"],
    remainingQuanity: json["remaining_quanity"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "quantity": quantity,
    "used_quanity": usedQuanity,
    "remaining_quanity": remainingQuanity,
  };
}