// To parse this JSON data, do
//
//     final updateSubLocationModel = updateSubLocationModelFromJson(jsonString);

import 'dart:convert';

UpdateSubLocationModel updateSubLocationModelFromJson(String str) =>
    UpdateSubLocationModel.fromJson(json.decode(str));

String updateSubLocationModelToJson(UpdateSubLocationModel data) =>
    json.encode(data.toJson());

class UpdateSubLocationModel {
  String status;
  String code;
  String message;

  UpdateSubLocationModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory UpdateSubLocationModel.fromJson(Map<String, dynamic> json) =>
      UpdateSubLocationModel(
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
