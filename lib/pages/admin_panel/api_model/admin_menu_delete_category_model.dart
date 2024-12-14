// To parse this JSON data, do
//
//     final deleteStoreByIdModel = deleteStoreByIdModelFromJson(jsonString);

import 'dart:convert';

AdminMenuDeleteCategoryByIdModel adminmenudeleteategoryByIdModelFromJson(
        String str) =>
    AdminMenuDeleteCategoryByIdModel.fromJson(json.decode(str));

String adminmenudeleteategoryByIdModelToJson(
        AdminMenuDeleteCategoryByIdModel data) =>
    json.encode(data.toJson());

class AdminMenuDeleteCategoryByIdModel {
  String status;
  String code;
  String message;

  AdminMenuDeleteCategoryByIdModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminMenuDeleteCategoryByIdModel.fromJson(
          Map<String, dynamic> json) =>
      AdminMenuDeleteCategoryByIdModel(
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
