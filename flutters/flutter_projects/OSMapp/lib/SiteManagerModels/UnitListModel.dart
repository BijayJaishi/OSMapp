// To parse this JSON data, do
//
//     final unitListModel = unitListModelFromJson(jsonString);

import 'dart:convert';

UnitListModel unitListModelFromJson(String str) => UnitListModel.fromJson(json.decode(str));

String unitListModelToJson(UnitListModel data) => json.encode(data.toJson());

class UnitListModel {
  int status;
  String message;
  List<UnitDatum> data;

  UnitListModel({
    this.status,
    this.message,
    this.data,
  });

  factory UnitListModel.fromJson(Map<String, dynamic> json) => UnitListModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<UnitDatum>.from(json["data"].map((x) => UnitDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UnitDatum {
  String id;
  String unit;

  UnitDatum({
    this.id,
    this.unit,
  });

  factory UnitDatum.fromJson(Map<String, dynamic> json) => UnitDatum(
    id: json["id"] == null ? null : json["id"],
    unit: json["unit"] == null ? null : json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "unit": unit == null ? null : unit,
  };
}
