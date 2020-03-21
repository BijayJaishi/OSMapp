// To parse this JSON data, do
//
//     final siteAttendance = siteAttendanceFromJson(jsonString);

import 'dart:convert';

SiteAttendance siteAttendanceFromJson(String str) => SiteAttendance.fromJson(json.decode(str));

String siteAttendanceToJson(SiteAttendance data) => json.encode(data.toJson());

class SiteAttendance {
  int status;
  String message;
  List<SiteDatum> data;

  SiteAttendance({
    this.status,
    this.message,
    this.data,
  });

  factory SiteAttendance.fromJson(Map<String, dynamic> json) => SiteAttendance(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SiteDatum>.from(json["data"].map((x) => SiteDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SiteDatum {
  String siteName;
  String siteId;
  String totalStaff;
  String present;
  String absent;

  SiteDatum({
    this.siteName,
    this.siteId,
    this.totalStaff,
    this.present,
    this.absent,
  });

  factory SiteDatum.fromJson(Map<String, dynamic> json) => SiteDatum(
    siteName: json["site_name"] == null ? null : json["site_name"],
    siteId: json["site_id"] == null ? null : json["site_id"],
    totalStaff: json["TotalStaff"] == null ? null : json["TotalStaff"],
    present: json["Present"] == null ? null : json["Present"],
    absent: json["Absent"] == null ? null : json["Absent"],
  );

  Map<String, dynamic> toJson() => {
    "site_name": siteName == null ? null : siteName,
    "site_id": siteId == null ? null : siteId,
    "TotalStaff": totalStaff == null ? null : totalStaff,
    "Present": present == null ? null : present,
    "Absent": absent == null ? null : absent,
  };
}
