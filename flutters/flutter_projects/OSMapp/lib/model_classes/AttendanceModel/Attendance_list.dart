// To parse this JSON data, do
//
//     final attendanceList = attendanceListFromJson(jsonString);

import 'dart:convert';

AttendanceList attendanceListFromJson(String str) => AttendanceList.fromJson(json.decode(str));

String attendanceListToJson(AttendanceList data) => json.encode(data.toJson());

class AttendanceList {
  int status;
  String message;
  String data;

  AttendanceList({
    this.status,
    this.message,
    this.data,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
  };
}
