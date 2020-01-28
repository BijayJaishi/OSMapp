// To parse this JSON data, do
//
//     final siteList = siteListFromJson(jsonString);

import 'dart:convert';

SiteList siteListFromJson(String str) => SiteList.fromJson(json.decode(str));

String siteListToJson(SiteList data) => json.encode(data.toJson());

class SiteList {
  int status;
  String message;
  List<Datum> data;

  SiteList({
    this.status,
    this.message,
    this.data,
  });

  factory SiteList.fromJson(Map<String, dynamic> json) => SiteList(
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
  String siteName;
  String location;

  Datum({
    this.siteName,
    this.location,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    siteName: json["site_name"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "site_name": siteName,
    "location": location,
  };
}
