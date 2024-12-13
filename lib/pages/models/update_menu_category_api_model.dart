// To parse this JSON data, do
//
//     final updateItemCategoryModel = updateItemCategoryModelFromJson(jsonString);

import 'dart:convert';

UpdateItemCategoryModel updateItemCategoryModelFromJson(String str) =>
    UpdateItemCategoryModel.fromJson(json.decode(str));

String updateItemCategoryModelToJson(UpdateItemCategoryModel data) =>
    json.encode(data.toJson());

class UpdateItemCategoryModel {
  String status;
  String code;
  String message;

  UpdateItemCategoryModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory UpdateItemCategoryModel.fromJson(Map<String, dynamic> json) =>
      UpdateItemCategoryModel(
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
