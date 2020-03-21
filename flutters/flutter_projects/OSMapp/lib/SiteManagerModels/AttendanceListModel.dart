// To parse this JSON data, do
//
//     final attendanceListModel = attendanceListModelFromJson(jsonString);

import 'dart:convert';

AttendanceListModel attendanceListModelFromJson(String str) => AttendanceListModel.fromJson(json.decode(str));

String attendanceListModelToJson(AttendanceListModel data) => json.encode(data.toJson());

class AttendanceListModel {
  int status;
  String message;
  List<AttendanceDatum> data;

  AttendanceListModel({
    this.status,
    this.message,
    this.data,
  });

  factory AttendanceListModel.fromJson(Map<String, dynamic> json) => AttendanceListModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<AttendanceDatum>.from(json["data"].map((x) => AttendanceDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class AttendanceDatum {
  String id;
  String fullname;

  AttendanceDatum({
    this.id,
    this.fullname,
  });

  factory AttendanceDatum.fromJson(Map<String, dynamic> json) => AttendanceDatum(
    id: json["id"] == null ? null : json["id"],
    fullname: json["fullname"] == null ? null : json["fullname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fullname": fullname == null ? null : fullname,
  };
}
