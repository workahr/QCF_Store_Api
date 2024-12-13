// To parse this JSON data, do
//
//     final deleteStoreByIdModel = deleteStoreByIdModelFromJson(jsonString);

import 'dart:convert';

DeleteStoreByIdModel deleteStoreByIdModelFromJson(String str) =>
    DeleteStoreByIdModel.fromJson(json.decode(str));

String deleteStoreByIdModelToJson(DeleteStoreByIdModel data) =>
    json.encode(data.toJson());

class DeleteStoreByIdModel {
  String status;
  String code;
  String message;

  DeleteStoreByIdModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DeleteStoreByIdModel.fromJson(Map<String, dynamic> json) =>
      DeleteStoreByIdModel(
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
