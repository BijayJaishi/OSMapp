// To parse this JSON data, do
//
//     final overHeadExpensePerSiteList = overHeadExpensePerSiteListFromJson(jsonString);

import 'dart:convert';

OverHeadExpensePerSiteList overHeadExpensePerSiteListFromJson(String str) => OverHeadExpensePerSiteList.fromJson(json.decode(str));

String overHeadExpensePerSiteListToJson(OverHeadExpensePerSiteList data) => json.encode(data.toJson());

class OverHeadExpensePerSiteList {
  int status;
  String message;
  List<OverHeadCostDatum> data;

  OverHeadExpensePerSiteList({
    this.status,
    this.message,
    this.data,
  });

  factory OverHeadExpensePerSiteList.fromJson(Map<String, dynamic> json) => OverHeadExpensePerSiteList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<OverHeadCostDatum>.from(json["data"].map((x) => OverHeadCostDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OverHeadCostDatum {
  DateTime payDate;
  List<Expense> expenses;

  OverHeadCostDatum({
    this.payDate,
    this.expenses,
  });

  factory OverHeadCostDatum.fromJson(Map<String, dynamic> json) => OverHeadCostDatum(
    payDate: json["pay_date"] == null ? null : DateTime.parse(json["pay_date"]),
    expenses: json["expenses"] == null ? null : List<Expense>.from(json["expenses"].map((x) => Expense.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pay_date": payDate == null ? null : "${payDate.year.toString().padLeft(4, '0')}-${payDate.month.toString().padLeft(2, '0')}-${payDate.day.toString().padLeft(2, '0')}",
    "expenses": expenses == null ? null : List<dynamic>.from(expenses.map((x) => x.toJson())),
  };
}

class Expense {
  String id;
  String expName;
  String price;
  DateTime payDate;

  Expense({
    this.id,
    this.expName,
    this.price,
    this.payDate,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    id: json["id"] == null ? null : json["id"],
    expName: json["exp_name"] == null ? null : json["exp_name"],
    price: json["price"] == null ? null : json["price"],
    payDate: json["pay_date"] == null ? null : DateTime.parse(json["pay_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "exp_name": expName == null ? null : expName,
    "price": price == null ? null : price,
    "pay_date": payDate == null ? null : "${payDate.year.toString().padLeft(4, '0')}-${payDate.month.toString().padLeft(2, '0')}-${payDate.day.toString().padLeft(2, '0')}",
  };
}
