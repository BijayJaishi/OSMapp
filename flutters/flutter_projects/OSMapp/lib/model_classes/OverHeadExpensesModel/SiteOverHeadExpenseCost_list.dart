// To parse this JSON data, do
//
//     final siteOverHeadExpenseCostList = siteOverHeadExpenseCostListFromJson(jsonString);

import 'dart:convert';

SiteOverHeadExpenseCostList siteOverHeadExpenseCostListFromJson(String str) => SiteOverHeadExpenseCostList.fromJson(json.decode(str));

String siteOverHeadExpenseCostListToJson(SiteOverHeadExpenseCostList data) => json.encode(data.toJson());

class SiteOverHeadExpenseCostList {
  int status;
  String message;
  List<SiteOverHeadDatum> data;

  SiteOverHeadExpenseCostList({
    this.status,
    this.message,
    this.data,
  });

  factory SiteOverHeadExpenseCostList.fromJson(Map<String, dynamic> json) => SiteOverHeadExpenseCostList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SiteOverHeadDatum>.from(json["data"].map((x) => SiteOverHeadDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SiteOverHeadDatum {
  String siteId;
  String siteName;
  String price;

  SiteOverHeadDatum({
    this.siteId,
    this.siteName,
    this.price,
  });

  factory SiteOverHeadDatum.fromJson(Map<String, dynamic> json) => SiteOverHeadDatum(
    siteId: json["site_id"] == null ? null : json["site_id"],
    siteName: json["site_name"] == null ? null : json["site_name"],
    price: json["price"] == null ? null : json["price"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId == null ? null : siteId,
    "site_name": siteName == null ? null : siteName,
    "price": price == null ? null : price,
  };
}
