// To parse this JSON data, do
//
//     final updateItemCategoryModel = updateItemCategoryModelFromJson(jsonString);

import 'dart:convert';

AdminMenuUpdateItemCategoryModel adminmenuupdateItemCategoryModelFromJson(
        String str) =>
    AdminMenuUpdateItemCategoryModel.fromJson(json.decode(str));

String adminmenuupdateItemCategoryModelToJson(
        AdminMenuUpdateItemCategoryModel data) =>
    json.encode(data.toJson());

class AdminMenuUpdateItemCategoryModel {
  String status;
  String code;
  String message;

  AdminMenuUpdateItemCategoryModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminMenuUpdateItemCategoryModel.fromJson(
          Map<String, dynamic> json) =>
      AdminMenuUpdateItemCategoryModel(
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
