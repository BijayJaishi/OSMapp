// To parse this JSON data, do
//
//     final salaryList = salaryListFromJson(jsonString);

import 'dart:convert';

SalaryList salaryListFromJson(String str) => SalaryList.fromJson(json.decode(str));

String salaryListToJson(SalaryList data) => json.encode(data.toJson());

class SalaryList {
  int status;
  String message;
  String data;

  SalaryList({
    this.status,
    this.message,
    this.data,
  });

  factory SalaryList.fromJson(Map<String, dynamic> json) => SalaryList(
    status: json["status"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}
