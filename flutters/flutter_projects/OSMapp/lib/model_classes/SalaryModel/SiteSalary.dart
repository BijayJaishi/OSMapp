// To parse this JSON data, do
//
//     final siteSalary = siteSalaryFromJson(jsonString);

import 'dart:convert';

SiteSalary siteSalaryFromJson(String str) => SiteSalary.fromJson(json.decode(str));

String siteSalaryToJson(SiteSalary data) => json.encode(data.toJson());

class SiteSalary {
  int status;
  String message;
  List<SalaryDatum> data;

  SiteSalary({
    this.status,
    this.message,
    this.data,
  });

  factory SiteSalary.fromJson(Map<String, dynamic> json) => SiteSalary(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SalaryDatum>.from(json["data"].map((x) => SalaryDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SalaryDatum {
  String siteId;
  String totalsal;
  String siteName;

  SalaryDatum({
    this.siteId,
    this.totalsal,
    this.siteName,
  });

  factory SalaryDatum.fromJson(Map<String, dynamic> json) => SalaryDatum(
    siteId: json["site_id"] == null ? null : json["site_id"],
    totalsal: json["totalsal"] == null ? null : json["totalsal"],
    siteName: json["site_name"] == null ? null : json["site_name"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId == null ? null : siteId,
    "totalsal": totalsal == null ? null : totalsal,
    "site_name": siteName == null ? null : siteName,
  };
}
