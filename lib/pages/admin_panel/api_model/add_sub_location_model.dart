// To parse this JSON data, do
//
//     final addSubLocationModel = addSubLocationModelFromJson(jsonString);

import 'dart:convert';

AddSubLocationModel addSubLocationModelFromJson(String str) =>
    AddSubLocationModel.fromJson(json.decode(str));

String addSubLocationModelToJson(AddSubLocationModel data) =>
    json.encode(data.toJson());

class AddSubLocationModel {
  String status;
  String code;
  String message;

  AddSubLocationModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AddSubLocationModel.fromJson(Map<String, dynamic> json) =>
      AddSubLocationModel(
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
