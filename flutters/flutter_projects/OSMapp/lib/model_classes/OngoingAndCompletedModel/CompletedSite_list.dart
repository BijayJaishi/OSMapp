// To parse this JSON data, do
//
//     final completedList = completedListFromJson(jsonString);

import 'dart:convert';

CompletedList completedListFromJson(String str) => CompletedList.fromJson(json.decode(str));

String completedListToJson(CompletedList data) => json.encode(data.toJson());

class CompletedList {
  int status;
  String message;
  List<CompletedDatum> data;

  CompletedList({
    this.status,
    this.message,
    this.data,
  });

  factory CompletedList.fromJson(Map<String, dynamic> json) => CompletedList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<CompletedDatum>.from(json["data"].map((x) => CompletedDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CompletedDatum {
  String siteId;
  String siteName;
  String location;

  CompletedDatum({
    this.siteId,
    this.siteName,
    this.location,
  });

  factory CompletedDatum.fromJson(Map<String, dynamic> json) => CompletedDatum(
    siteId: json["site_id"] == null ? null : json["site_id"],
    siteName: json["site_name"] == null ? null : json["site_name"],
    location: json["location"] == null ? null : json["location"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId == null ? null : siteId,
    "site_name": siteName == null ? null : siteName,
    "location": location == null ? null : location,
  };
}
