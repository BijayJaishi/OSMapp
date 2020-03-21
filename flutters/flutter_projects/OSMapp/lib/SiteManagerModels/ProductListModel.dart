// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  int status;
  String message;
  List<ProductDatum> data;

  ProductListModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<ProductDatum>.from(json["data"].map((x) => ProductDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductDatum {
  String id;
  String productName;

  ProductDatum({
    this.id,
    this.productName,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
    id: json["id"] == null ? null : json["id"],
    productName: json["product_name"] == null ? null : json["product_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_name": productName == null ? null : productName,
  };
}
