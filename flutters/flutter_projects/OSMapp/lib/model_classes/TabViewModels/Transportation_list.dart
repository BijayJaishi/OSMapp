// To parse this JSON data, do
//
//     final transportationList = transportationListFromJson(jsonString);

import 'dart:convert';

TransportationList transportationListFromJson(String str) => TransportationList.fromJson(json.decode(str));

String transportationListToJson(TransportationList data) => json.encode(data.toJson());

class TransportationList {
  int status;
  String message;
  List<Datum> data;

  TransportationList({
    this.status,
    this.message,
    this.data,
  });

  factory TransportationList.fromJson(Map<String, dynamic> json) => TransportationList(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String transId;
  String imgName;
  String name;
  String description;
  DateTime transDate;

  Datum({
    this.transId,
    this.imgName,
    this.name,
    this.description,
    this.transDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    transId: json["trans_id"],
    imgName: json["img_name"],
    name: json["name"],
    description: json["description"],
    transDate: DateTime.parse(json["trans_date"]),
  );

  Map<String, dynamic> toJson() => {
    "trans_id": transId,
    "img_name": imgName,
    "name": name,
    "description": description,
    "trans_date": "${transDate.year.toString().padLeft(4, '0')}-${transDate.month.toString().padLeft(2, '0')}-${transDate.day.toString().padLeft(2, '0')}",
  };
}
