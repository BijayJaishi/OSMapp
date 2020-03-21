// To parse this JSON data, do
//
//     final siteTransportationCost = siteTransportationCostFromJson(jsonString);

import 'dart:convert';

SiteTransportationCost siteTransportationCostFromJson(String str) => SiteTransportationCost.fromJson(json.decode(str));

String siteTransportationCostToJson(SiteTransportationCost data) => json.encode(data.toJson());

class SiteTransportationCost {
  int status;
  String message;
  List<TransportDatum> data;

  SiteTransportationCost({
    this.status,
    this.message,
    this.data,
  });

  factory SiteTransportationCost.fromJson(Map<String, dynamic> json) => SiteTransportationCost(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<TransportDatum>.from(json["data"].map((x) => TransportDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TransportDatum {
  String siteId;
  String totalcost;
  String siteName;

  TransportDatum({
    this.siteId,
    this.totalcost,
    this.siteName,
  });

  factory TransportDatum.fromJson(Map<String, dynamic> json) => TransportDatum(
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
