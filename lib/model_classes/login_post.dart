// To parse this JSON data, do
//
//     final loginPost = loginPostFromJson(jsonString);

import 'dart:convert';

LoginPost loginPostFromJson(String str) => LoginPost.fromJson(json.decode(str));

String loginPostToJson(LoginPost data) => json.encode(data.toJson());

class LoginPost {
  String identity;
  String password;

  LoginPost({
    this.identity,
    this.password,
  });

  factory LoginPost.fromJson(Map<String, dynamic> json) => LoginPost(
    identity: json["identity"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "identity": identity,
    "password": password,
  };
}
