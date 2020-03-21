// To parse this JSON data, do
//
//     final siteExpenditure = siteExpenditureFromJson(jsonString);

import 'dart:convert';

SiteExpenditure siteExpenditureFromJson(String str) => SiteExpenditure.fromJson(json.decode(str));

String siteExpenditureToJson(SiteExpenditure data) => json.encode(data.toJson());

class SiteExpenditure {
  int status;
  String message;
  List<ExpenditureDatum> data;

  SiteExpenditure({
    this.status,
    this.message,
    this.data,
  });

  factory SiteExpenditure.fromJson(Map<String, dynamic> json) => SiteExpenditure(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ExpenditureDatum>.from(json["data"].map((x) => ExpenditureDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ExpenditureDatum {
  String siteId;
  String totalcost;
  String siteName;

  ExpenditureDatum({
    this.siteId,
    this.totalcost,
    this.siteName,
  });

  factory ExpenditureDatum.fromJson(Map<String, dynamic> json) => ExpenditureDatum(
    siteId: json["site_id"] == null ? null : json["site_id"],
    totalcost: json["totalcost"] == null ? null : json["totalcost"],
    siteName: json["site_name"] == null ? null : json["site_name"],
  );

  Map<String, dynamic> toJson() => {
    "site_id": siteId == null ? null : siteId,
    "totalcost": totalcost == null ? null : totalcost,
    "site_name": siteName == null ? null : siteName,
  };
}
