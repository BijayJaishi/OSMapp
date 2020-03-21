// To parse this JSON data, do
//
//     final managerSitelist = managerSitelistFromJson(jsonString);

import 'dart:convert';

ManagerSitelist managerSitelistFromJson(String str) => ManagerSitelist.fromJson(json.decode(str));

String managerSitelistToJson(ManagerSitelist data) => json.encode(data.toJson());

class ManagerSitelist {
  int status;
  String message;
  List<ManagerSite> data;

  ManagerSitelist({
    this.status,
    this.message,
    this.data,
  });

  factory ManagerSitelist.fromJson(Map<String, dynamic> json) => ManagerSitelist(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ManagerSite>.from(json["data"].map((x) => ManagerSite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ManagerSite {
  String siteId;
  String siteName;
  String location;
  String imgName;

  ManagerSite({
    this.siteId,
    this.siteName,
    this.location,
    this.imgName,
  });

  factory ManagerSite.fromJson(Map<String, dynamic> json) => ManagerSite(
    siteId: json["site_id"] == null ? null : json["site_id"],
    siteName: json["site_name"] == null ? null : json["site_name"],
    location: json["location"] == null ? null : json["location"],
    imgName: json["img_name"] == null ? null : json["img_name"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId == null ? null : siteId,
    "site_name": siteName == null ? null : siteName,
    "location": location == null ? null : location,
    "img_name": imgName == null ? null : imgName,
  };
}