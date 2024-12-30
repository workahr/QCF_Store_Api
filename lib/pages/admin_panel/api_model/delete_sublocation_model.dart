// To parse this JSON data, do
//
//     final deletePrimeLocationModel = deletePrimeLocationModelFromJson(jsonString);

import 'dart:convert';

DeleteSubLocationModel deleteSubLocationModelFromJson(String str) =>
    DeleteSubLocationModel.fromJson(json.decode(str));

String deleteSubLocationModelToJson(DeleteSubLocationModel data) =>
    json.encode(data.toJson());

class DeleteSubLocationModel {
  String status;
  String code;
  String message;

  DeleteSubLocationModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DeleteSubLocationModel.fromJson(Map<String, dynamic> json) =>
      DeleteSubLocationModel(
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
