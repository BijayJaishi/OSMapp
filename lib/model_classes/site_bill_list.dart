// To parse this JSON data, do
//
//     final siteBillList = siteBillListFromJson(jsonString);

import 'dart:convert';

SiteBillList siteBillListFromJson(String str) => SiteBillList.fromJson(json.decode(str));

String siteBillListToJson(SiteBillList data) => json.encode(data.toJson());

class SiteBillList {
  int status;
  String message;
  List<Datum> data;

  SiteBillList({
    this.status,
    this.message,
    this.data,
  });

  factory SiteBillList.fromJson(Map<String, dynamic> json) => SiteBillList(
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
  String id;
  String billNo;
  String imgName;
  DateTime billDate;

  Datum({
    this.id,
    this.billNo,
    this.imgName,
    this.billDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    billNo: json["bill_no"],
    imgName: json["img_name"],
    billDate: DateTime.parse(json["bill_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bill_no": billNo,
    "img_name": imgName,
    "bill_date": billDate.toIso8601String(),
  };
}
