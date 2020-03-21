// To parse this JSON data, do
//
//     final expenditureList = expenditureListFromJson(jsonString);

import 'dart:convert';

ExpenditureList expenditureListFromJson(String str) => ExpenditureList.fromJson(json.decode(str));

String expenditureListToJson(ExpenditureList data) => json.encode(data.toJson());

class ExpenditureList {
  int status;
  String message;
  String data;

  ExpenditureList({
    this.status,
    this.message,
    this.data,
  });

  factory ExpenditureList.fromJson(Map<String, dynamic> json) => ExpenditureList(
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
