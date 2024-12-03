// To parse this JSON data, do
//
//     final deleteStoremodel = deleteStoremodelFromJson(jsonString);

import 'dart:convert';

DeleteStoremodel deleteStoremodelFromJson(String str) =>
    DeleteStoremodel.fromJson(json.decode(str));

String deleteStoremodelToJson(DeleteStoremodel data) =>
    json.encode(data.toJson());

class DeleteStoremodel {
  String status;
  String code;
  String message;

  DeleteStoremodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DeleteStoremodel.fromJson(Map<String, dynamic> json) =>
      DeleteStoremodel(
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
