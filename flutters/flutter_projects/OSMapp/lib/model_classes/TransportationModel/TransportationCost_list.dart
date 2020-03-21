// To parse this JSON data, do
//
//     final transportationCostList = transportationCostListFromJson(jsonString);

import 'dart:convert';

TransportationCostList transportationCostListFromJson(String str) => TransportationCostList.fromJson(json.decode(str));

String transportationCostListToJson(TransportationCostList data) => json.encode(data.toJson());

class TransportationCostList {
  int status;
  String message;
  String data;

  TransportationCostList({
    this.status,
    this.message,
    this.data,
  });

  factory TransportationCostList.fromJson(Map<String, dynamic> json) => TransportationCostList(
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
