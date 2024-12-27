// To parse this JSON data, do
//
//     final updateItemCategoryModel = updateItemCategoryModelFromJson(jsonString);

import 'dart:convert';

AdmineditorderModel admineditorderModelFromJson(String str) =>
    AdmineditorderModel.fromJson(json.decode(str));

String adminmenuupdateItemCategoryModelToJson(AdmineditorderModel data) =>
    json.encode(data.toJson());

class AdmineditorderModel {
  String status;
  String code;
  String message;

  AdmineditorderModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdmineditorderModel.fromJson(Map<String, dynamic> json) =>
      AdmineditorderModel(
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
