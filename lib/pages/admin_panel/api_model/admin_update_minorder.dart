// To parse this JSON data, do
//
//     final updateItemCategoryModel = updateItemCategoryModelFromJson(jsonString);

import 'dart:convert';

Adminupdateminorder adminminorderModelFromJson(String str) =>
    Adminupdateminorder.fromJson(json.decode(str));

String adminminorderModelToJson(Adminupdateminorder data) =>
    json.encode(data.toJson());

class Adminupdateminorder {
  String status;
  String code;
  String message;

  Adminupdateminorder({
    required this.status,
    required this.code,
    required this.message,
  });

  factory Adminupdateminorder.fromJson(Map<String, dynamic> json) =>
      Adminupdateminorder(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
