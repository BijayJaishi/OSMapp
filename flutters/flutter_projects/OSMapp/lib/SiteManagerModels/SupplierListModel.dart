// To parse this JSON data, do
//
//     final supplierListModel = supplierListModelFromJson(jsonString);

import 'dart:convert';

SupplierListModel supplierListModelFromJson(String str) => SupplierListModel.fromJson(json.decode(str));

String supplierListModelToJson(SupplierListModel data) => json.encode(data.toJson());

class SupplierListModel {
  int status;
  String message;
  List<SupplierDatum> data;

  SupplierListModel({
    this.status,
    this.message,
    this.data,
  });

  factory SupplierListModel.fromJson(Map<String, dynamic> json) => SupplierListModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<SupplierDatum>.from(json["data"].map((x) => SupplierDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SupplierDatum {
  String id;
  String name;

  SupplierDatum({
    this.id,
    this.name,
  });

  factory SupplierDatum.fromJson(Map<String, dynamic> json) => SupplierDatum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}
