// To parse this JSON data, do
//
//     final siteImageList = siteImageListFromJson(jsonString);

import 'dart:convert';

SiteImageList siteImageListFromJson(String str) => SiteImageList.fromJson(json.decode(str));

String siteImageListToJson(SiteImageList data) => json.encode(data.toJson());

class SiteImageList {
  int status;
  String message;
  List<Datum> data;

  SiteImageList({
    this.status,
    this.message,
    this.data,
  });

  factory SiteImageList.fromJson(Map<String, dynamic> json) => SiteImageList(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String site;
  String title;
  String desc;
  DateTime photoDate;
  List<Images> image;

  Datum({
    this.site,
    this.title,
    this.desc,
    this.photoDate,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    site: json["site"],
    title: json["title"],
    desc: json["desc"],
    photoDate: DateTime.parse(json["photo_date"]),
    image: List<Images>.from(json["image"].map((x) => Images.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "site": site,
    "title": title,
    "desc": desc,
    "photo_date": photoDate.toIso8601String(),
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
  };
}

class Images {
  String id;
  String photoId;
  String imgName;

  Images({
    this.id,
    this.photoId,
    this.imgName,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"],
    photoId: json["photo_id"],
    imgName: json["img_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "photo_id": photoId,
    "img_name": imgName,
  };
}
