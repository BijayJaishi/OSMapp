// To parse this JSON data, do
//
//     final overHeadExpenseList = overHeadExpenseListFromJson(jsonString);

import 'dart:convert';

OverHeadExpenseList overHeadExpenseListFromJson(String str) => OverHeadExpenseList.fromJson(json.decode(str));

String overHeadExpenseListToJson(OverHeadExpenseList data) => json.encode(data.toJson());

class OverHeadExpenseList {
  int status;
  String message;
  List<OverHeadExpenseDatum> data;

  OverHeadExpenseList({
    this.status,
    this.message,
    this.data,
  });

  factory OverHeadExpenseList.fromJson(Map<String, dynamic> json) => OverHeadExpenseList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<OverHeadExpenseDatum>.from(json["data"].map((x) => OverHeadExpenseDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OverHeadExpenseDatum {
  String price;

  OverHeadExpenseDatum({
    this.price,
  });

  factory OverHeadExpenseDatum.fromJson(Map<String, dynamic> json) => OverHeadExpenseDatum(
    price: json["price"] == null ? null : json["price"],
  );

  Map<String, dynamic> toJson() => {
    "price": price == null ? null : price,
  };
}
