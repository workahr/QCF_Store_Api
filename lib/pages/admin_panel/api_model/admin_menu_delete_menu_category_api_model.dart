// To parse this JSON data, do
//
//     final deleteStoreByIdModel = deleteStoreByIdModelFromJson(jsonString);

import 'dart:convert';

AdminDeleteStoreByIdModel admindeleteStoreByIdModelFromJson(String str) =>
    AdminDeleteStoreByIdModel.fromJson(json.decode(str));

String admindeleteStoreByIdModelToJson(AdminDeleteStoreByIdModel data) =>
    json.encode(data.toJson());

class AdminDeleteStoreByIdModel {
  String status;
  String code;
  String message;

  AdminDeleteStoreByIdModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AdminDeleteStoreByIdModel.fromJson(Map<String, dynamic> json) =>
      AdminDeleteStoreByIdModel(
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
