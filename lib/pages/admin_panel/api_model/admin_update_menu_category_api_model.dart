// To parse this JSON data, do
//
//     final updateItemCategoryModel = updateItemCategoryModelFromJson(jsonString);

import 'dart:convert';

AdminUpdateItemCategoryModel adminupdateItemCategoryModelFromJson(String str) =>
    AdminUpdateItemCategoryModel.fromJson(json.decode(str));

String adminupdateItemCategoryModelToJson(AdminUpdateItemCategoryModel data) =>
    json.encode(data.toJson());

class AdminUpdateItemCategoryModel {
  String status;
  String code;
  String message;

  AdminUpdateItemCategoryModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminUpdateItemCategoryModel.fromJson(Map<String, dynamic> json) =>
      AdminUpdateItemCategoryModel(
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
